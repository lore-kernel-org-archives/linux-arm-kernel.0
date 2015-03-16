From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Mar 2015 15:34:15 +0100
Subject: [PATCH v6 0/6] Introducing the Alpine platform.
In-Reply-To: <55017dd1.aJJEZc1WHJV4oo+1%tsahee@annapurnalabs.com>
References: <55017dd1.aJJEZc1WHJV4oo+1%tsahee@annapurnalabs.com>
Message-ID: <3082390.gOR4Xx0rHs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 13:51:45 Tsahee Zidenberg wrote:
> Please consider the following for inclusion in 4.1
> 
> ---
> Annapurna Labs(TM) is a technology company providing innovative solutions
> including chips, software, and systems for the datacenter and enterprise
> infrastructure.
> 
> Alpine(TM) is one of Annapurna Labs? chip products targeting storage and
> networking applications. It is a complete Platform-On-Chip,
> integrating 2-4 cortex-A15 cores and multiple innovations to provide
> a seamless networking and storage fabric for enterprise and datacenter
> equipment.
> 

Applied all six patches to the arm-soc tree now, welcome as our
latest platform maintainer!

I've put patches 1-4 and 6 into next/soc, and patch 5 into next/dt,
so they will fit better in with the branches for the other platforms.

	Arnd
