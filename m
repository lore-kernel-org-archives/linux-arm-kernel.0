From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:17:43 +0200
Subject: [PATCH 2/3] ARM: dts: uniphier: add ProXstream2 Vodka board
 support
In-Reply-To: <1444899934-4754-3-git-send-email-yamada.masahiro@socionext.com>
References: <1444899934-4754-1-git-send-email-yamada.masahiro@socionext.com>
 <1444899934-4754-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <63719761.5kc6F97FjG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 18:05:33 Masahiro Yamada wrote:
> +       aliases {
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               serial2 = &serial2;
> +               i2c0 = &i2c0;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               i2c6 = &i2c6;
> 

This looks like a typo, you probably mean

               i2c0 = &i2c0;
               i2c1 = &i2c4;
               i2c2 = &i2c5;
               i2c3 = &i2c6;

Can you re-send this?

	Arnd
