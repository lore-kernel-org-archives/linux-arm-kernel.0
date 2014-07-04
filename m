From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 4 Jul 2014 10:05:05 +0100
Subject: [PATCH v2 0/4] Tegra USB probe order issue fix
In-Reply-To: <1404436179-10745-1-git-send-email-ttynkkynen@nvidia.com>
References: <1404436179-10745-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140704090505.GD31812@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 02:09:35AM +0100, Tuomas Tynkkynen wrote:
> Hi all,
> 
> Here's a second version of the probe order issue series. This time I've
> added the USB1 resets to the PHYs, thus replacing the really ugly parts
> with something slightly better. Old device trees will still probe
> successfully, but instead of this bugfix they'll get a dev_warn().

Given the binding looks sane and doesn't unnecessarily break existing
DTBs, for patches 1-3:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
