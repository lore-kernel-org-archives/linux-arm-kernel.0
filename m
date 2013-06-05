From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 5 Jun 2013 13:24:57 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-single: enhance to configure
 multiple pins of different modules
In-Reply-To: <1369145282-14419-3-git-send-email-prakash.pm@ti.com>
References: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
 <1369145282-14419-3-git-send-email-prakash.pm@ti.com>
Message-ID: <CAN1soZw9F-LeUVcYmJ7wKOnacKsBgkGookMrDM11KNsQ0sxw9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 10:08 PM, Manjunathappa, Prakash
<prakash.pm@ti.com> wrote:
> Add support to configure multiple pins in each register, existing
> implementation added by [1] does not support full fledge multiple pin
> configuration in single register, reports a pin clash when different
> modules configure different bits of same register. The issue reported
> and discussed here
> http://www.spinics.net/lists/arm-kernel/msg235213.html
>
> With pinctrl-single,bits-per-mux property specified, use function-mask
> property to find out number pins to configure. Allocate and register
> pin control functions based sub mask.
>
> Tested on da850/omap-l138 EVM.
> does not support variable submask for pins.
> does not support pinconf.
>
> [1] "pinctrl: pinctrl-single: Add pinctrl-single,bits type of mux"
> (9e605cb68a21d5704839a192a46ebcf387773704),
>
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Reported-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Tested-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Excuse me for response late.

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
