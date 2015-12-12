From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sat, 12 Dec 2015 11:44:45 +0100
Subject: [linux-sunxi] [PATCH v2] spi: dts: sun4i: Add support for
 inter-word wait cycles using the SPI Wait Clock Register
In-Reply-To: <1449911980.29015.7.camel@plaes.org>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
 <1449911980.29015.7.camel@plaes.org>
Message-ID: <CAGNoLaOUnvpP6XYkeCc64goVY7uQp21-cCjjXymTfOjzViacLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-12-12 10:19 GMT+01:00 Priit Laes <plaes@plaes.org>:
> On Fri, 2015-12-11 at 23:45 +0100, Marcus Weseloh wrote:
> [...]
>> +- sun4i,spi-word-wait-ns: hardware based delay in nanoseconds between
>> +                       transmission of words
>
> Should be 'allwinner,spi-word-wait-ns'

Thanks for the review, I will change the prefix.

> [...]
>> +     /* Setup wait time beteen words */
> typo

Ah, yes. I will wait for more review comments and post a v3 after that.

Cheers,

   Marcus
