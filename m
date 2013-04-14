From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 14 Apr 2013 19:01:31 +0200
Subject: [PATCH 08/30] i2c: s3c2410: make header file local
In-Reply-To: <20130414122035.GB9013@the-dreams.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-9-git-send-email-arnd@arndb.de>
 <20130414122035.GB9013@the-dreams.de>
Message-ID: <201304141901.32286.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 14. April 2013, 14:20:35 schrieb Wolfram Sang:
> On Thu, Apr 11, 2013 at 02:04:50AM +0200, Arnd Bergmann wrote:
> > No other file in the kernel besides i2c-s3c2410.c uses the current
> > plat/regs-iic.h, so we can simply move the header file to live in the
> > same directory as the driver, as a preparation to multiplatform builds.
> 
> What about putting the regs in the driver itself?

they already are :-) [0] and Arnd will drop this patch in his next iteration 
[1].


Heiko


[0] 
https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/commit/?h=i2c/for-
next&id=e636602ac2613da8c1777cb42443223994be4107

[1] Message-Id: <201304121011.13028.arnd@arndb.de>
