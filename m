From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 03:44:41 -0700
Subject: [PATCH 1/2] arm/dts: Mark vcxio, v2v1 and v1v8 regulators as
 always on
In-Reply-To: <1343653940-16614-2-git-send-email-rnayak@ti.com>
References: <1343653940-16614-1-git-send-email-rnayak@ti.com>
 <1343653940-16614-2-git-send-email-rnayak@ti.com>
Message-ID: <20120807104441.GW11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [120730 06:17]:
> vcxio, v2v1 and v1v8 are expected to be always on, update the dtsi
> for twl6030 to reflect this.
> 
> commit '86f5fc' regulator: core: Mark all DT based boards as having
> full constraints) caused these to be disabled at late boot causing
> OMAP4 boards (using twl6030) to lockup.

Thanks I'll apply this one into fixes.

Tony
