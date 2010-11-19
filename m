From: janakiram.sistla@gmail.com (Janakiram Sistla)
Date: Fri, 19 Nov 2010 10:49:47 -0800
Subject: [PATCH v4 2/2] msm: gpio: Add irq support to v2 gpiolib.
In-Reply-To: <alpine.DEB.2.00.1011191035210.10052@gbean-linux.qualcomm.com>
References: <1290109970-26752-1-git-send-email-gbean@codeaurora.org>
	<1290109970-26752-2-git-send-email-gbean@codeaurora.org>
	<AANLkTimTsyhjHJZggFO31C-2RswpmKWn-V4pGEiQ3+_2@mail.gmail.com>
	<alpine.DEB.2.00.1011181229380.26784@gbean-linux.qualcomm.com>
	<AANLkTi=p02P=-JQ9+FynFyM1yxrAh3utKTD2uzqhnLxK@mail.gmail.com>
	<alpine.DEB.2.00.1011181256470.29924@gbean-linux.qualcomm.com>
	<AANLkTiknYmWOmiFXGp6h2dT==aMuGs3BtXi82b6Vdq5i@mail.gmail.com>
	<alpine.DEB.2.00.1011191035210.10052@gbean-linux.qualcomm.com>
Message-ID: <AANLkTiknSudbo_j+nqBqmds49CWyqXf0jpvz+DTYH-zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 10:37 AM, Gregory Bean <gbean@codeaurora.org> wrote:
> On Thu, 18 Nov 2010, Janakiram Sistla wrote:
>
>>> Targets with the v2 block define CONFIG_MSM_V2_TLMM.
>>
>> So in that case we can name ?it as gpio-tlmm.c ??
>
> No, not and have things be any clearer.
>
> All MSM chips have a TLMM block. ?The older chips have
> version 1 (v1) of the TLMM block. ?The newer chips have v2.
I think that we should differentiate the new gpio infrastructure with
appropriate naming that makes the diff between v1 and v2
> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
