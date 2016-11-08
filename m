From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 08 Nov 2016 17:20:36 +0000
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <20161108133411.GA31754@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
 <20161108133215.GQ1041@n2100.armlinux.org.uk>
 <20161108133411.GA31754@n2100.armlinux.org.uk>
Message-ID: <1478625636.27416.7.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-11-08 at 13:34 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 01:32:15PM +0000, Russell King - ARM Linux wrote:
> > Unfortunately, my drm-tda998x-devel branch is slightly out of date with
> > these patches it's the original set of 10 patches.  I've not pushed
> > these ones out to that branch yet, as I've three additional patches on
> > top of these which aren't "ready" for pushing out.
> 
> Here's the delta between the branch and what I just posted:
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
[...]

I have a working setup for HDMI audio on Juno an would like to test this
series but am struggling to work out which patches to apply in what
order to what branch, can you be specific? (I've tried various
combinations of patches series from the list, drm-tda998x-devel, and the
diff you posted)

Thanks

-- 
Tixy
