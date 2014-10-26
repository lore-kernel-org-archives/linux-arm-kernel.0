From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sun, 26 Oct 2014 16:04:24 +0100
Subject: [RFC 4/7] soc: qcom: Add Shared Memory Manager driver
In-Reply-To: <20141017145158.GB28882@sonymobile.com>
References: <1412037291-16880-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412037291-16880-5-git-send-email-bjorn.andersson@sonymobile.com>
 <5435AD8E.2000109@codeaurora.org> <20141017145158.GB28882@sonymobile.com>
Message-ID: <544D0D78.1030204@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 17.10.2014 um 16:51 schrieb Bjorn Andersson:
> On Wed 08 Oct 14:33 PDT 2014, Jeffrey Hugo wrote:
>> On 9/29/2014 6:34 PM, Bjorn Andersson wrote:
>>> diff --git a/include/linux/soc/qcom/qcom_smem.h b/include/linux/soc/qcom/qcom_smem.h
>>
>> include/soc/ already exists, why add include/linux/soc?
>>
> 
> I have to admit I don't really understand why the tegra stuff is in
> include/soc/, will have to do some more investigation.

AFAIR soc/ was mach-* stuff that is shared between arm and arm64.

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
