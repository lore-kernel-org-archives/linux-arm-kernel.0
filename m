From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 15:59:40 +0000
Subject: [PATCH v3 04/12] arm: vdso: enforce monotonic and realtime as
 inline
In-Reply-To: <20171027222531.57223-1-salyzyn@android.com>
References: <20171027222531.57223-1-salyzyn@android.com>
Message-ID: <20171030155940.GR20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 03:25:28PM -0700, Mark Salyzyn wrote:
> Ensure monotonic and realtime are inline, small price to pay for
> high volume common request.

Is this just based on a hunch, or is it based on proper measurement?
If proper measurement, where's the data?  What CPU was it measured
with?  How does this change affect other CPUs?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
