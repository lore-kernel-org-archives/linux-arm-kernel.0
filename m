From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 09:29:22 +0100
Subject: PROBLEM: ARM Cache policy on single armv7 processor lead to low
 DRAM performance
In-Reply-To: <CAOEkoLw3Y5h2P_aFeMKgHYyKZpQvsQsOPOLOuvaYZGOe+rHJWQ@mail.gmail.com>
References: <CAOEkoLw3Y5h2P_aFeMKgHYyKZpQvsQsOPOLOuvaYZGOe+rHJWQ@mail.gmail.com>
Message-ID: <20170516082922.GY22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 11:59:30AM +0800, Zhao Yibin wrote:
> We met some DDR performance issue caused by armv7 cache policy, hope you
> can help.
> On a single armv7(Cortex-A7) processor system, the arm linux kernel,
> without CONFIG_SMP, the cache policy is set to write-back no-allocate,

It should be write-back read-allocate.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
