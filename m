From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 8 Aug 2011 20:26:44 +0200
Subject: [PATCH 12/15] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <CABb+yY08vGuvp4uVm3nd0FvFoXa04jmDOaQYcu324q7326a5Lw@mail.gmail.com>
References: <1311744697-10264-1-git-send-email-boojin.kim@samsung.com>
	<201108081955.39626.heiko@sntech.de>
	<CABb+yY08vGuvp4uVm3nd0FvFoXa04jmDOaQYcu324q7326a5Lw@mail.gmail.com>
Message-ID: <201108082026.45456.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag 08 August 2011, 20:16:58 schrieben Sie:
> On Mon, Aug 8, 2011 at 11:25 PM, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Montag 08 August 2011, 19:47:58 schrieb Jassi Brar:
> >> Btw, this spi driver is for S3C64xx(with pl080) and S5P(with pl330)
> >> series, both of which
> >> have DMAENGINE drivers. May be it could be directly switched to using
> >> those, rather than
> >> via Samsung's wrapper driver.
> >> Or am I overlooking something ?
> > 
> > yep, at least the S3C2416/2450 HSSPI which should use this driver.
> 
> Seems you keep some patches private ;)  the spi driver isn't enabled
> for 2416 in mainline.
It's not so private [1], but isn't working yet :-). I'm still new to the whole 
kernel development stuff and seem to be the only one working on this device 
family.

I know from comparing s3c2416 and s3c64xx manuals that the hsspi part is the 
same but still have some learning to do to get it to work and also need 
drivers for the other side of the spi connection.

The Asus eeeReader DR-900 uses a wlan chip supported by libertas. So having a 
"verified" driver on the other side might help me in getting the spi driver to 
work.


Heiko


[1] https://gitorious.org/oyo-hack every e-book reader with Sipix display 
seems to be made from the same model line.
