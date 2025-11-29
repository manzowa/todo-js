/**
 * @description      :
 * @author           : christian
 * @group            :
 * @created          : 07/10/2021 - 21:00:26
 *
 **/

const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const isProduction = process.env.NODE_ENV === 'production';

const config = {
    entry: {
        main: path.join(__dirname, 'src/app.js'),
    },
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: '[name].[contenthash].js',
        clean: true,
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: path.resolve(__dirname, 'index.html'),
            favicon: path.resolve(__dirname, 'src/favicon.png'),
        }),
        new CopyWebpackPlugin({
            patterns: [
                {
                    from: path.resolve(__dirname, 'src/favicon.png'),
                    to: path.resolve(__dirname, 'dist'),
                },
                {
                    from: path.resolve(__dirname, 'src/logo.png'),
                    to: path.resolve(__dirname, 'dist'),
                },
            ],
        }),

        // ⬇⬇⬇ ADD THIS ⬇⬇⬇
        ...(isProduction
            ? [
                new MiniCssExtractPlugin({
                    filename: '[name].[contenthash].css',
                }),
            ]
            : []),
        // ⬆⬆⬆ ADD THIS ⬆⬆⬆
    ],
    module: {
        rules: [
            {
                test: /\.js$/,
                loader: 'babel-loader',
            },
            {
                test: /\.css$/,
                use: [
                    isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
                    'css-loader',
                ],
            },
            {
                test: /\.s[ac]ss$/,
                use: [
                    isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
                    'css-loader',
                    'sass-loader',
                ],
            },
            {
                test: /\.(png|jpg|gif|eot|ttf|woff|woff2|svg)$/i,
                type: 'asset/resource',
            },
        ],
    },
    devServer: {
        static: {
            directory: path.join(__dirname, 'dist'),
        },
        compress: true,
        port: 4000,
        open: true,
        hot: true,
        liveReload: true,
    },
};

module.exports = () => {
    config.mode = isProduction ? 'production' : 'development';
    return config;
};
