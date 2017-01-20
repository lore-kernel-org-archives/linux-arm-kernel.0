From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Jan 2017 16:24:50 -0800
Subject: [PATCH v1 0/3] [for arm-soc] mach-tango DT updates for v4.11
In-Reply-To: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
References: <bd989965-fa8a-a175-5e14-8467f01e6d5b@sigmadesigns.com>
Message-ID: <20170120002450.GA685@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 03:50:45PM +0100, Marc Gonzalez wrote:
> Hello arm-soc maintainers,
> 
> Here are my DT updates for tango4.
> 
> I also have local changes for NAND and DMA nodes, but the DMA driver
> is not upstream yet, so it seems there's no point in sending these.
> 
> Marc Gonzalez (3):
>   ARM: dts: tango4: Add alias for eth0
>   ARM: dts: tango4: Import MMC nodes
>   ARM: dts: tango4: Import USB nodes

Thanks, applied all three to next/dt!


-Olof
