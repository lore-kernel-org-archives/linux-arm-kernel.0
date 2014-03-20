From: marex@denx.de (Marek Vasut)
Date: Thu, 20 Mar 2014 05:01:16 +0100
Subject: FEC ethernet issues [Was: PL310 errata workarounds]
In-Reply-To: <201403200005.56334.marex@denx.de>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
 <201403200005.56334.marex@denx.de>
Message-ID: <201403200501.16881.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 20, 2014 at 12:05:56 AM, Marek Vasut wrote:
> On Wednesday, March 19, 2014 at 11:51:38 PM, Russell King - ARM Linux wrote:

[...]

> > As far as the 600Mbps receive - you need the right conditions for that.
> > I select the performance cpufreq governor after boot, and let the boot
> > quiesce.  It doesn't take much for it to drop back to 460Mbps - another
> > running process other than iperf -s is sufficient to do that.
> > 
> > Let me know how you get on with this.
> 
> Roger that, will do, thank you very much !

I did some test and I observe no dips in the speed, nice work. Thanks !

I will try to get feedback from more boards and get back to you with the 
results.

Best regards,
Marek Vasut
