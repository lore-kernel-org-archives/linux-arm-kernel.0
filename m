From: nm@ti.com (Nishanth Menon)
Date: Tue, 29 Oct 2013 11:19:00 -0500
Subject: [PATCHv9 00/43] ARM: TI SoC clock DT conversion
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Message-ID: <526FDFF4.9030806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 10:56 AM, Tero Kristo wrote:
<snip>
> Testing done:
> - omap3-beagle: boot + suspend/resume (ret + off)
> - omap4-panda-es: boot + suspend/resume
> - omap5-uevm: boot
> - dra7-evm: boot
> - am335x-bone: boot
> 
> Test branches available:
> 
> tree: https://github.com/t-kristo/linux-pm.git

<snip>
> Fully functioning test branch: 3.12-rc6-dt-clks-v9
> 
^^ I tested this branch (boot testing):
Beagle-XM: http://pastebin.com/50A1qtFq (crashes + clkdm issues, dpll5
failed to transition)
Panda-ES: http://pastebin.com/dWMp7D1z (bandgap_fclk not found)
OMAP5-UEVM: http://pastebin.com/pHEx6Yzg (omap-gpmc 50000000.gpmc:
error: clk_get)
DRA7-EVM: http://pastebin.com/uYNQ6Sss
BeagleBone-Black: http://pastebin.com/biGXS2vi
AM335x-evm: http://pastebin.com/K7qwJpCb


-- 
Regards,
Nishanth Menon
