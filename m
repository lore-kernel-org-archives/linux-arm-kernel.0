From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Dec 2016 18:30:47 -0800
Subject: [PATCH v2 0/2] FPGA: TS-7300 FPGA manager
In-Reply-To: <20161214022845.5692-1-f.fainelli@gmail.com>
References: <20161214022845.5692-1-f.fainelli@gmail.com>
Message-ID: <3364bca1-1dbf-e28a-88f6-94ca61a4576f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/13/2016 06:28 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for loading bitstreams into the Altera Cyclone II
> connected to an EP9302 on a TS-7300 board.
> 
> Changes in v2:
> 
> - rebased against fpga/for-next
> - added defines for configuration bits and delays
> - added error mesage if ioremap() fails
> - detailed how the configuration through CPLD is done

I forgot to fix a function signature while rebasing, let me resubmit this.

> 
> Florian Fainelli (2):
>   ARM: ep93xx: Register ts73xx-fpga manager driver for TS-7300
>   FPGA: Add TS-7300 FPGA manager
> 
>  arch/arm/mach-ep93xx/ts72xx.c |  26 +++++++
>  drivers/fpga/Kconfig          |   7 ++
>  drivers/fpga/Makefile         |   1 +
>  drivers/fpga/ts73xx-fpga.c    | 162 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/fpga/ts73xx-fpga.c
> 

-- 
Florian
