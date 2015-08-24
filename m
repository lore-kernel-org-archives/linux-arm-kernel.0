From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 11:58:39 +0900
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <1440383359.2670.15.camel@perches.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
 <1440383359.2670.15.camel@perches.com>
Message-ID: <CAK7LNASYUaHkarg8CghDdFWGzTtN90qv2X7_rL-q0CDjAKPZaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,


2015-08-24 11:29 GMT+09:00 Joe Perches <joe@perches.com>:
> On Mon, 2015-08-24 at 11:18 +0900, Masahiro Yamada wrote:
>> This commit adds support for UniPhier outer cache controller.
>> All the UniPhier SoCs are equipped with the L2 cache, while the L3
>> cache is currently only integrated on PH1-Pro5 SoC.
>
> style trivia:
>
> You might add and use
>         #define pr_fmt(fmt) "uniphier: " fmt
> before any other #include so all of the pr_<level>
> uses are automatically prefixed.


I did not know that.  Thanks!

I will do so for the whole series in v2.





-- 
Best Regards
Masahiro Yamada
