From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 13 Dec 2013 09:58:01 +0100
Subject: [PATCH 1/2] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <CACRpkdaHy8BDmj+noGqhOm=c0UmSn6pKb9WbGEPtP7M-KwYxLA@mail.gmail.com>
References: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
 <201312130857.23890.heiko@sntech.de>
 <CACRpkdaHy8BDmj+noGqhOm=c0UmSn6pKb9WbGEPtP7M-KwYxLA@mail.gmail.com>
Message-ID: <201312130958.01781.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 13. Dezember 2013, 09:20:39 schrieb Linus Walleij:
> On Fri, Dec 13, 2013 at 8:57 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > I'm not the maintainer of s3c24xx,
> 
> Maybe you should be. I have a hard time getting the generic
> Samsung maintainers' attention to S3C patches...
> 
> > but this looks nice ;-)
> 
> Do you think you can test it on hardware?

on an Openmoko Neo Freerunner (S3C2442)
Tested-by: Heiko Stuebner <heiko@sntech.de>
