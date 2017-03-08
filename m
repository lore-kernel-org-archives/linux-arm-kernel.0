From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 8 Mar 2017 09:19:56 -0600
Subject: [PATCH 0/2] ARM: dts: socfpga: Add support for PMU on
 Arria5/Cyclone5
In-Reply-To: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1488297132-21553-1-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <d723d5df-a700-3781-e8a5-4e57185585f8@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/28/2017 09:52 AM, Florian Vaussard wrote:
> Hi,
> 
> These patches add suport for ARM Performance Monitor Units on Arria5 and
> Cyclone5 SoCFPGA. This was tested on a Cyclone 5 SoC DK board.
> 
> Side note: the same change can be probably applied to Arria10 as well,
> but we do not have the hardware here to test.
> 
> Regards,
> Florian
> 
> Florian Vaussard (2):
>   ARM: dts: socfpga: Add labels for CPU nodes
>   ARM: dts: socfpga: Add support for PMU
> 
>  arch/arm/boot/dts/socfpga.dtsi | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Applied!

Thanks,

Dinh
