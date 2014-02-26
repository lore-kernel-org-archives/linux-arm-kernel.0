From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 26 Feb 2014 13:15:06 -0600
Subject: linux-next: manual merge of the crypto tree with the arm-soc tree
In-Reply-To: <20140226150159.7ea5e60285ee9d0193bde811@canb.auug.org.au>
References: <20140226150159.7ea5e60285ee9d0193bde811@canb.auug.org.au>
Message-ID: <B4102448-9875-4C8A-94A1-E2EDFC5011E2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 25, 2014, at 10:01 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Herbert,
> 
> Today's linux-next merge of the crypto tree got a conflict in
> drivers/char/hw_random/Kconfig between commit 2257ffbca73c ("hwrng: msm:
> switch Kconfig to ARCH_QCOM depends") from the arm-soc tree and commit
> f9bee046c915 ("hwrng: msm: switch Kconfig to ARCH_QCOM depends") from the
> crypto tree.
> 
> Two version of the same patch ... I just kept the arm-soc version.

Herbert,

Was trying to keep all the ARCH_QCOM Kconfig updates together and via arm-soc.git

thanks

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
