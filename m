From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Oct 2017 12:48:17 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: enable NEON based crypto
In-Reply-To: <20170906184729.7980-1-ard.biesheuvel@linaro.org>
References: <20170906184729.7980-1-ard.biesheuvel@linaro.org>
Message-ID: <20171002194817.GQ4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ard Biesheuvel <ard.biesheuvel@linaro.org> [170906 11:48]:
> Enable kernel mode NEON and the various NEON based crypto algorithms,
> which are between 1.4x (AES-XTS) and 2.4x (AES-GCM) faster than
> scalar code (measured on Cortex-A8).
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> Note that this was tested using the updated GHASH code that is queued
> for v4.14

Applying finally into omap-for-v4.15/defconfig thanks.

Tony
