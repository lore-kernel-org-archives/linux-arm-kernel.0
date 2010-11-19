From: gbean@codeaurora.org (Gregory Bean)
Date: Fri, 19 Nov 2010 10:37:45 -0800 (PST)
Subject: [PATCH v4 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <AANLkTiknYmWOmiFXGp6h2dT==aMuGs3BtXi82b6Vdq5i@mail.gmail.com>
References: <1290109970-26752-1-git-send-email-gbean@codeaurora.org>
	<1290109970-26752-2-git-send-email-gbean@codeaurora.org>
	<AANLkTimTsyhjHJZggFO31C-2RswpmKWn-V4pGEiQ3+_2@mail.gmail.com>
	<alpine.DEB.2.00.1011181229380.26784@gbean-linux.qualcomm.com>
	<AANLkTi=p02P=-JQ9+FynFyM1yxrAh3utKTD2uzqhnLxK@mail.gmail.com>
	<alpine.DEB.2.00.1011181256470.29924@gbean-linux.qualcomm.com>
	<AANLkTiknYmWOmiFXGp6h2dT==aMuGs3BtXi82b6Vdq5i@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1011191035210.10052@gbean-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Nov 2010, Janakiram Sistla wrote:

>> Targets with the v2 block define CONFIG_MSM_V2_TLMM.
>
> So in that case we can name  it as gpio-tlmm.c ??

No, not and have things be any clearer.

All MSM chips have a TLMM block.  The older chips have
version 1 (v1) of the TLMM block.  The newer chips have v2.

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
