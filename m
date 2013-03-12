From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 12:28:30 +0000
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC and APE6EVM board support
In-Reply-To: <20130312045559.19701.77841.sendpatchset@w520>
References: <20130312045559.19701.77841.sendpatchset@w520>
Message-ID: <201303121228.31067.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Magnus Damm wrote:
> ARM: shmobile: r8a73a4 SoC and APE6EVM board support
> 
> [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
> [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support
> [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
> [PATCH 04/04] ARM: shmobile: APE6EVM support
> 
> This series adds initial support for r8a73a4 and APE6EVM. The SoC
> is known as r8a73a4 which is built around Cortex-A15 and makes use
> of SCIF for serial and IRQC interrupt controller for external IRQs.
> 
> This initial SoC and board support is providing limited DT-only
> support and a very basic C-version of board support. In the future
> improved PINCTRL and clock framework support will be added, followed
> by SMP support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patches look good so far. I assume you have made them in a way that lets
you easily keep around non-DT support internally, right?

	Arnd
