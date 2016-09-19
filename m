From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 19 Sep 2016 11:56:30 +0100
Subject: [PATCH 1/3] nvmem: add NXP LPC18xx OTP driver
In-Reply-To: <20160913161241.22492-2-manabian@gmail.com>
References: <20160913161241.22492-1-manabian@gmail.com>
 <20160913161241.22492-2-manabian@gmail.com>
Message-ID: <b46055ae-84f8-1ee8-bb4e-91d1722c66c8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/16 17:12, Joachim Eastwood wrote:
> Add simple read only driver for the internal OTP (One Time Programmable)
> memory found on all NXP LPC18xx and LPC43xx devices.
>
> The OTP memory is split into 4 banks each with 4 32-bits word. Some of
> the banks contain predefined data while others are for general purpose
> and user programmable via the OTP API in ROM. Note that writing to the
> OTP memory is not yet supported.
>
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  drivers/nvmem/Kconfig       |  10 ++++
>  drivers/nvmem/Makefile      |   2 +
>  drivers/nvmem/lpc18xx_otp.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 drivers/nvmem/lpc18xx_otp.c
>

Patch looks good to me.

I will pick this patch + bindings patch once rc1 lands in.

Thanks,
srini
