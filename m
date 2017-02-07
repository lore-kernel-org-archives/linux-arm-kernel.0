From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Feb 2017 15:14:15 +0100
Subject: [GIT PULL] ARM: mvebu: dt for v4.11 (#3)
In-Reply-To: <87vasvz575.fsf@free-electrons.com>
References: <87vasvz575.fsf@free-electrons.com>
Message-ID: <3013051.dlCd81dF2f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 31, 2017 3:15:10 PM CET Gregory CLEMENT wrote:
> ----------------------------------------------------------------
> mvebu dt for 4.11 (part 3)
> 
> Add support for Marvell switches with integrated CPUs based on Armada XP
> 
> ----------------------------------------------------------------
> Chris Packham (2):
>       ARM: dts: mvebu: Add device tree for 98DX3236 SoCs
>       ARM: dts: mvebu: Add device tree for db-dxbc2 and db-xc3-24g4xg boards

Pulled into next/dt, nice to see this getting added! Just for my information,
do we also support the actual switch driver in Linux, or just the parts that
are common with Armada?

	Arnd
