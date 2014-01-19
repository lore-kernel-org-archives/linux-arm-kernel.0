From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Jan 2014 11:18:18 +0800
Subject: [PATCH 0/2] DT updates for Hummingboard and new Cubox-i
In-Reply-To: <20140116182211.GX15937@n2100.arm.linux.org.uk>
References: <20140116182211.GX15937@n2100.arm.linux.org.uk>
Message-ID: <20140119031816.GD16158@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 06:22:12PM +0000, Russell King - ARM Linux wrote:
> Now that the Cubox-i has been released, and I have one, I've been able to
> update things a little.  Out of the following two patches, the first one
> I think is critical to be merged before the microsom support hits
> mainline, since it drops the flexcan support from the microsom level,
> moving it to the Hummingboard level.

I will be out of town for a few days, and won't be online until next
weekend.  So please send the patch directly to arm-soc folks, so that
they can send it together with imx-dt-3.14 stuff.

arm-soc folks, please take this as another ping for my imx-dt-3.14 pull
request :)

Shawn

> 
> That doesn't have _too_ much visible effect, but it's something which
> should not be there (since as far as the microsom is concerned, there's
> nothing special about these pads.)
