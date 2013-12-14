From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 14 Dec 2013 15:57:31 -0800
Subject: [PATCH v2 2/3] clk: bcm281xx: add initial clock framework support
In-Reply-To: <529F4B4F.4020405@linaro.org>
References: <529F4B0F.2020801@linaro.org> <529F4B4F.4020405@linaro.org>
Message-ID: <20131214235731.26321.53050@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alex Elder (2013-12-04 07:33:35)
> +       return true;
> +}
> +
> +/* A bit position must be less than the number of bits in a 32-bit
> register. */

Hi Alex,

The patch is corrupt at line 634 and several other places below.  Did
you edit it manually? I'm happy with the series after reviewing it but
it cannot be applied. Can you fix the issue and send me a pull request?

Thanks,
Mike
