From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Tue, 30 Sep 2014 17:51:37 +0800
Subject: [PATCH 3/6] arm64: dts/Makefile: Add support for Spreadtrum's
 Shark64 SoC.
In-Reply-To: <20140929144752.GP16977@sirena.org.uk>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-4-git-send-email-zhang.lyra@gmail.com>
 <20140929144752.GP16977@sirena.org.uk>
Message-ID: <CAAfSe-sdz=DkJteLCLwLg_2-KWRY8mp1O+ZZ=j2YJtskXNT6Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark

[use plain text pattern to send again]

2014-09-29 22:47 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, Sep 29, 2014 at 08:04:50PM +0800, zhang.lyra at gmail.com wrote:
>
>>  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
>>  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
>> +dtb-$(CONFIG_ARCH_SHARK64) += sprd_shark64.dtb
>
> It's better to keep lists in Makefiles and Kconfig sorted
> alphanumerically, that way there's less chance of conflicts when
> applying patches or merging different branches.

Thank you very much for your review and explain why this way is
better. I'll address this change in V2.

Best regards,
Chunyan
