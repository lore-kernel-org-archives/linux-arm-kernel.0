From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Apr 2014 17:15:01 +0800
Subject: [PATCH] ARM: dts: stmpe-ts: fix wrong bindings
In-Reply-To: <2acd964e18e59b35996d042a3dd6e99b@agner.ch>
References: <1386620111-1413-1-git-send-email-stefan@agner.ch>
 <201312092132.29575.marex@denx.de>
 <2acd964e18e59b35996d042a3dd6e99b@agner.ch>
Message-ID: <20140402091459.GB10283@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 09:48:58AM +0200, Stefan Agner wrote:
> Am 2013-12-09 21:32, schrieb Marek Vasut:
> > On Monday, December 09, 2013 at 09:15:11 PM, Stefan Agner wrote:
> >> Fix bindings for STMPE touchscreen device to match the documented
> >> bindings and the actual bindings used by the driver.
> >>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >> I don't have any of these hardware, but the error is obvious. The device
> >> probably works anyway since the device/driver will use default values.
> > 
> > Full agreement here.
> > 
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > 
> > btw. I plan to rework the STMPE TS as it doesn't work nicely on my device at 
> > all. I am seriously lacking time, but I will try! ;-)
> > 
> > Best regards,
> > Marek Vasut
> 
> Hi Shawn,
> 
> Just noticed that I forgot to add you when sending this patch. I guess
> this should go through your tree...

You should probably resend the patch against the latest kernel, and with
imx change in a separate patch.

Shawn
