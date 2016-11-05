From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 5 Nov 2016 13:33:31 +0300
Subject: [PATCH v6 7/7] arm64: dts: NS2: add AMAC ethernet support
In-Reply-To: <20161104163024.GA6128@broadcom.com>
References: <1478236262-3351-1-git-send-email-jon.mason@broadcom.com>
 <1478236262-3351-8-git-send-email-jon.mason@broadcom.com>
 <69ecd9b9-d495-9dfa-ad26-4fa622d951a0@cogentembedded.com>
 <20161104163024.GA6128@broadcom.com>
Message-ID: <c4a1b943-dce9-805d-30d4-4858b4a6ef23@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/2016 7:30 PM, Jon Mason wrote:

>>> Add support for the AMAC ethernet to the Broadcom Northstar2 SoC device
>>> tree
>>>
>>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>>> ---
>>> arch/arm64/boot/dts/broadcom/ns2-svk.dts |  5 +++++
>>> arch/arm64/boot/dts/broadcom/ns2.dtsi    | 12 ++++++++++++
>>> 2 files changed, 17 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>> index b09f3bc..c4d5442 100644
>>> --- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>> +++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
>>> @@ -56,6 +56,10 @@
>>> 	};
>>> };
>>>
>>> +&enet {
>>> +	status = "ok";
>>
>>    The spec dictates it should be "okay" (although "ok" is also recognized).
>
> The rest of the file uses "ok".  So, the addition above is consistent
> with the other entries.
>
> Perhaps a patch outside this series to convert the entire file from
> "ok" to "okay" would be acceptable to you.

    OK, it would...

>
> Thanks,
> Jon

MBR, Sergei
