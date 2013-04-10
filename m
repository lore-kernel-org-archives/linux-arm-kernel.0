From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 10 Apr 2013 13:02:27 +0200
Subject: [PATCH v5 2/3] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <310301ce35da$724dff60$56e9fe20$%kim@samsung.com>
References: <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <1365543270-10736-2-git-send-email-dianders@chromium.org>
 <310301ce35da$724dff60$56e9fe20$%kim@samsung.com>
Message-ID: <20130410110226.GA3533@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 07:59:17PM +0900, Kukjin Kim wrote:
> Doug Anderson wrote:
> > 
> > We need to use the i2c-arbitrator to talk to any of the devices on i2c
> > bus 4 on exynos5250-snow so that we don't confuse the embedded
> > controller (EC).  Add the i2c-arbitrator to the device tree.  As we
> > add future devices (keyboard, sbs, tps65090) we'll add them on top of
> > this.
> > 
> > The arbitrated bus is numbered 104 simply as a convenience to make it
> > easier for people poking around to guess that it might have something
> > to do with the physical bus 4.
> > 
> > The addition is split between the cros5250-common and the snow device
> > tree file since not all cros5250-class devices use arbitration.
> > 
> > Signed-off-by: Doug Anderson <dianders@chromium.org>
> 
> I'm fine on 2nd and 3rd patches. Shall I take only two patches without 1st
> one in samsung tree?

Please wait for my OK on patch 1. Or ack patches 2 and 3 and I will pick
them up. I am fine with both.
