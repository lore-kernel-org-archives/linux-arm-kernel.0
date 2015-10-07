From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 7 Oct 2015 19:13:54 +0300
Subject: [PATCH v5 10/23] arm64: introduce is_a32_task and is_a32_thread
 (for AArch32 compat)
In-Reply-To: <5613929D.6070802@linaro.org>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <1443564860-31208-11-git-send-email-ynorov@caviumnetworks.com>
 <5613929D.6070802@linaro.org>
Message-ID: <20151007161354.GA28128@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:21:33PM +0300, Andrey Konovalov wrote:
> Hi Yury,
> 
> With this patch set 4.3 kernel fails to build with arch/arm64/configs/defconfig plus CONFIG_AARCH32_EL0=y
> and CONFIG_ARM64_ILP32=y giving the following three errors (the 3d one is warning actually):

[...]

> Thanks,
> Andrey

Hi, Andrey,

Thank you. If you're interested in early testing, you can pull
my working branch here:

https://github.com/norov/linux/tree/ilp

There, build for all combinations of CONFIG_AARCH32_EL0 and
CONFIG_ARM64_ILP32 is fixed.

I can also share my testing tools, if needed.

BR,
Yury.
