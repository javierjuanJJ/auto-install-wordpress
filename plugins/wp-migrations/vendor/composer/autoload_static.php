<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInit929733ebe4c6354afb435137b4349628
{
    public static $prefixLengthsPsr4 = array (
        'W' => 
        array (
            'WP\\' => 3,
        ),
        'M' => 
        array (
            'Migration\\' => 10,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'WP\\' => 
        array (
            0 => __DIR__ . '/../..' . '/src',
        ),
        'Migration\\' => 
        array (
            0 => __DIR__ . '/../..' . '/../../migrations',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInit929733ebe4c6354afb435137b4349628::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInit929733ebe4c6354afb435137b4349628::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}