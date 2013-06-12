From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Jun 2013 13:01:42 -0700
Subject: [PATCH v4 0/7] support Hisilicon SoC
In-Reply-To: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
References: <1370702843-27172-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130612200142.GD5162@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 08, 2013 at 10:47:16PM +0800, Haojian Zhuang wrote:
> Changelog:
> v4:
> 1. Add clk gate with HIWORD mask for Rockchip.
> 2. Update comments and code of HIWORD flags for mux/divider.
> 3. Append a mux without HIWORD mask in Hisilicon 3620.
> 4. Fix the pinmux setting in Hi4511.
> 
> v3:
> 1. Use clk_register_mux_table().
> 
> v2:
> 1. Reuse mux & divider driver. So append CLK_MUX_HIWORD_MASK &
> CLK_DIVIDER_HIWORD_MASK for Hi3620 SoC.
> 2. Fix system timer running too fast because wrong divider is choosen.
> 3. Remove .init_irq in DT machine descriptor.
> 

Hi,

I had some comments on the last two patches. I also haven't seen any acks from
Mike on any of the clock changes, which would be needed before we can pick them
up. He might want to merge them into his tree as well, if so we'll have to
setup a shared branch.


-Olof
