From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Wed, 14 Dec 2016 16:39:51 +0000
Subject: [PATCH v3 1/2] ARM: ep93xx: Register ts73xx-fpga manager driver
 for TS-7300
In-Reply-To: <20161214023553.9377-2-f.fainelli@gmail.com>
References: <20161214023553.9377-1-f.fainelli@gmail.com>
 <20161214023553.9377-2-f.fainelli@gmail.com>
Message-ID: <SN1PR0101MB15653914100FD7D819A071F4D09A0@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 13, 2016 7:36 PM, Florian Fainelli wrote:
>
> Register the TS-7300 FPGA manager device drivers which allows us to load
> bitstreams into the on-board Altera Cyclone II FPGA.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

For the ep93xx core change:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
