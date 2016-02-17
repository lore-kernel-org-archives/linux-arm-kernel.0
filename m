From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Feb 2016 12:39:21 +0900
Subject: [clk:clk-samsung-kconfig 2/2] drivers/clk/samsung/clk.h:142:17:
 error: invalid operands to binary | (have 'struct samsung_pll_clock *' and
 'struct samsung_pll_clock *')
In-Reply-To: <201602171104.YkeaxmIS%fengguang.wu@intel.com>
References: <201602171104.YkeaxmIS%fengguang.wu@intel.com>
Message-ID: <56C3EB69.2000307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.02.2016 12:22, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-samsung-kconfig
> head:   e83cb468452c25597e868d1ed778fa73fdaeca4c
> commit: e83cb468452c25597e868d1ed778fa73fdaeca4c [2/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
> config: mips-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e83cb468452c25597e868d1ed778fa73fdaeca4c
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 

I think this is the same as previous - patch which added dependency on
CLK_COMMON is not present. My tests on MIPS passed fine. Also attached
configs builds fine with the dependency applied.

Best regards,
Krzysztof
