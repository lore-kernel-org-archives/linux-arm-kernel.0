From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 11 Mar 2014 11:34:44 +0530
Subject: [PATCH v15 3/3] arm64: Add APM X-Gene SoC 15Gbps Multi-purpose
 PHY DTS entries
In-Reply-To: <20140310204549.GJ25290@htj.dyndns.org>
References: <1394213289-29565-1-git-send-email-lho@apm.com>
 <1394213289-29565-2-git-send-email-lho@apm.com>
 <1394213289-29565-3-git-send-email-lho@apm.com>
 <1394213289-29565-4-git-send-email-lho@apm.com>
 <CAPw-ZTmwFZjKT2+CUUp73TDXJcXy-bEY_sTNg-TtH-COzDnCfw@mail.gmail.com>
 <20140310204549.GJ25290@htj.dyndns.org>
Message-ID: <531EA77C.103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 11 March 2014 02:15 AM, Tejun Heo wrote:
> On Sun, Mar 09, 2014 at 10:23:33PM -0700, Loc Ho wrote:
>> Hi Tejun,
>>
>> On Fri, Mar 7, 2014 at 9:28 AM, Loc Ho <lho@apm.com> wrote:
>>
>>> This patch adds the DTS entries for the APM X-Gene SoC 15Gbps Multi-purpose
>>> PHY driver. The PHY for SATA controller 2 and 3 are enabled by default.
>>>
>>> Signed-off-by: Loc Ho <lho@apm.com>
>>> Signed-off-by: Tuan Phan <tphan@apm.com>
>>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>>> ---
>>>   arch/arm64/boot/dts/apm-storm.dtsi |   75
>>> ++++++++++++++++++++++++++++++++++++
>>>   1 files changed, 75 insertions(+), 0 deletions(-)
>>>
>>>
>> Kishon had pulled in the PHY doc/driver patches. Will you pulling in the
>> PHY DTS and the SATA host driver patches soon?
>
> Kishon, is the following branch the right one to pull into
> libata/for-3.15?
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next


My PULL request to Greg has this..
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git 
tags/for_3.15

Btw you can add my
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
for this patch.

Thanks
Kishon
