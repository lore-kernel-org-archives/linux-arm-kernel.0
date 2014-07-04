From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 4 Jul 2014 15:25:28 +0200
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <20140704131247.2c8ecde2@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140704131247.2c8ecde2@free-electrons.com>
Message-ID: <20140704132528.GD7773@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This doesn't work very well with the idea of having the OPP table
> statically encoded in to the Device Tree. Options are:
> 
>  - Improve the cpufreq-cpu0 driver so that the OPP table can be passed
>    through platform_data, and therefore built dynamically by the
>    platform code and passed when registering the cpufreq
>    platform_device.
> 
>  - Dynamically build/update the OPP table in the Device Tree.
> 
> Which option do you think is appropriate here?

It should also be noted that that applies to many Marvell SoCs.
Kirkwood and Dove are the same.

	 Andrew
