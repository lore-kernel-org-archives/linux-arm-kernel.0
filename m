From: nbd@openwrt.org (Felix Fietkau)
Date: Tue, 19 Jan 2016 00:14:59 +0100
Subject: CONFIG_CPU_SW_DOMAIN_PAN breakage on ARM11 MPCore
Message-ID: <569D71F3.7000408@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I just wasted a few hours debugging user space hangs after updating my
CNS3xxx device to Linux 4.4 - until I found this:
http://www.spinics.net/lists/arm-kernel/msg450888.html

I haven't seen any follow-up patches since that discussion in October,
and this patch resolves the issue in my test. Could you guys please get
this merged and pushed to stable to avoid wasting other people's time as
well?

If you want to solve the issue in a different way, I can also test
patches for you.

Thanks,

- Felix
