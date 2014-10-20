From: carlo@caione.org (Carlo Caione)
Date: Mon, 20 Oct 2014 14:01:02 +0200
Subject: [PATCH v3 0/3] ARM: meson: Add reset controller
In-Reply-To: <1413803985-8363-1-git-send-email-carlo@caione.org>
References: <1413803985-8363-1-git-send-email-carlo@caione.org>
Message-ID: <20141020120102.GC29697@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 01:19:42PM +0200, Carlo Caione wrote:
> Apparently several IPs found in the MesonX SoCs can be reset by programming a
> specific bit in a register in the so called AO (Always-On) domain. From the
> documentation released by Amlogic under NDA it is not clear which devices can
> be reset acting on this register. So far from the sources release by Amlogic it
> seems that at least two IPs use this register for reset: RTC and UART. Since I
> need it to reset the RTC, I wrote this small driver.

Hi Philipp,
a couple of minutes ago I received new documentation about the
controller. I'll submit a v4 soon.

Thanks,

-- 
Carlo Caione
