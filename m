From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:34:16 +0100
Subject: [GIT PULL] ARM: imx: cleanup for 3.19
In-Reply-To: <20141119070152.GE27759@dragon>
References: <20141119070152.GE27759@dragon>
Message-ID: <201411201734.16505.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014, Shawn Guo wrote:
> The i.MX cleanup for 3.19:
>  - Clean up reset handler for DT machines, since reset has been handled
>    in watchdog driver
>  - Remove unneeded .map_io hook for a couple of i.MX6 machines
>  - A few small i.MX6 device tree source cleanups
>  - Some random iomuxc and pllv3 code cleanup

Same comment as for the other branches, please rebase on -rc1.

	Arnd
