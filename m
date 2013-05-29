From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 29 May 2013 10:11:00 -0400
Subject: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
In-Reply-To: <5194D0AF.3010407@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com>
 <5193A875.1020000@ti.com> <5193B9AA.7020507@ti.com> <519488D3.5070003@ti.com>
 <5194D0AF.3010407@ti.com>
Message-ID: <51A60C74.4010307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Monsieur Benoit,

On 16-05-2013 08:27, Eduardo Valentin wrote:
> On 16-05-2013 03:20, Benoit Cousson wrote:
>> Hi Eduardo,
>>

<cut>

>> We need to check.
>>
> 
> 
> Yeah, I also dont think this will work, because we will reparent the
> interrupt, setting to a different controller. That will break the TALERT
> signal already defined at GIC (check original patch).
> 
> I propose keeping the way I sent. Unless there is a way to set two
> different controllers to same device.
> 

Any idea on this patch? Shall we keep the way it is?


>> Regards,
>> Benoit
>>
>>
>>>> Where is the gpio controller phandle?
>>>>
>>>> Usually it looks like this:
>>>>
>>>> 	gpios = <&gpio1 8 0>;
>>>>
>>>>
>>>> Regards,
>>>> Benoit
>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>>
> 
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/900f960b/attachment.sig>
