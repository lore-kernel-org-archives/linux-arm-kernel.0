From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Nov 2014 09:26:48 +0800
Subject: [RESEND PATCH V2 0/2] Add I2C and enable M41T0M6 RTC
In-Reply-To: <cover.1415852424.git.bhuvanchandra.dv@toradex.com>
References: <cover.1415852424.git.bhuvanchandra.dv@toradex.com>
Message-ID: <20141119012647.GB24042@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:05:30AM +0530, Bhuvanchandra DV wrote:
> Add I2C support on Colibri VFxx moduels and enable M41T0M6 RTC
> available on Colibri carrier boards.
> 
> Bhuvanchandra DV (2):
>   ARM: dts: vf-colibri: Add I2C support
>   ARM: dts: vf-colibri-eval-v3.dts: Enable ST-M41T0M6 RTC

Applied both, thanks.

> 
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi |   12 +++++++++++-
>  arch/arm/boot/dts/vf-colibri.dtsi         |   13 +++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.9.5
> 
