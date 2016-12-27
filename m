From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Dec 2016 09:57:47 -0800
Subject: [PATCH] ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd
 flags
In-Reply-To: <20161214213445.GD28424@amd>
References: <1481750984-11239-1-git-send-email-pali.rohar@gmail.com>
 <20161214213445.GD28424@amd>
Message-ID: <20161227175747.GX4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161214 13:34]:
> On Wed 2016-12-14 22:29:44, Pali Roh?r wrote:
> > Trying to initialize eMMC slot as SDIO or SD cause failure in n900 port of
> > qemu. eMMC itself is not detected and is not working.
> > 
> > Real Nokia N900 harware does not have this problem. As eMMC is really not
> > SDIO or SD based such change is harmless and will fix support for qemu.
> > 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v4.10/fixes thanks.

Tony
