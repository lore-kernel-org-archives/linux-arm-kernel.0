From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Apr 2016 20:48:48 +0200
Subject: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
In-Reply-To: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Message-ID: <20160414184848.GB2338@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> + - input-clk-rate : frequency rate of function clock used(in Hz). If omitted,
> +	the default clock rate is used. It is just used at rk3399 soc.

Why is this needed? Why don't we simply use the default or calculate the
best value somehow?

> + * @t_calc: Caculated rk3x private timings  that would
> + * be written into regs

double space

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/39434350/attachment.sig>
