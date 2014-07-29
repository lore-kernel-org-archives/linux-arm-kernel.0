From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 21:05:31 -0700
Subject: [PATCH v15 08/12] ARM: config: append lpae configuration
In-Reply-To: <1406555876-11989-9-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-9-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140729040531.GB8430@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 09:57:52PM +0800, Haojian Zhuang wrote:
> Append multi_v7_lpae_config. In this default configuration,
> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.

NACK. This is the nth time I have had to nack this patch.

You are enabling platforms here that don't have LPAE. Don't do that.

It's trivial to create a LPAE version of multi_v7 defconfig locally.


-Olof
