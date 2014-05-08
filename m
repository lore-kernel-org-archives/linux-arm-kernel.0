From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 May 2014 13:13:22 +0200
Subject: [PATCH] ARM: realview: basic device tree implementation
In-Reply-To: <26412341.aCOKep5CZC@wuerfel>
References: <1395826060-26662-1-git-send-email-linus.walleij@linaro.org>
 <4327457.yKTHVHA17K@wuerfel> <26412341.aCOKep5CZC@wuerfel>
Message-ID: <CACRpkdbiiahjY6n++MJqX=JyoiJoQAVVaDnsj5DM5kS2rOyXAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 10:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> I don't know if the ATAGS are actually correct in common boot loaders,
> since the kernel has been overriding them for ages.

The RealView U-Boot has not seen a commit since 2010 when
Peter Pearse retired but appears to pass incorrect ATAGs, 128MiB
@ 0x0 for all RealView variants.

But we need not worry about that for the DT boot path so much
as we can fix that up, just for legacy boots.

Yours,
Linus Walleij
