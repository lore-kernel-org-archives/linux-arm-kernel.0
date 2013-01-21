From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Jan 2013 18:02:33 +0530
Subject: [PATCH V5 3/3] ARM: davinci: da850: add NAND driver DT entries
In-Reply-To: <1358327261-9679-4-git-send-email-anilkumar.v@ti.com>
References: <1358327261-9679-1-git-send-email-anilkumar.v@ti.com>
 <1358327261-9679-4-git-send-email-anilkumar.v@ti.com>
Message-ID: <50FD3561.7010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anil,

On 1/16/2013 2:37 PM, Kumar, Anil wrote:
> Add NAND driver DT node and related pinctrl DT data to export NAND
> functionality on da850 evm.
> 
> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>

I applied all three patches in this series.

> +	nand_cs3 at 62000000 {
> +		compatible = "ti,davinci-nand";
> +		reg = <0x62000000 0x807ff
> +			0x68000000 0x8000>;

While applying I changed the indentation of this line so the two
addresses are aligned.

Thanks,
Sekhar
