From: c.aeschlimann@acn-group.ch (Christophe Aeschlimann)
Date: Mon, 21 Mar 2011 09:20:41 +0100
Subject: ALSA issue on DA850/OMAP-L138/AM18x
In-Reply-To: <4D762FEB.3010003@acn-group.ch>
References: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>	<4D5BDA3D.5080905@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024B83B5E4@dbde02.ent.ti.com>	<4D749A09.8050101@acn-group.ch>	<B85A65D85D7EB246BE421B3FB0FBB593024C0E5EC7@dbde02.ent.ti.com>
	<4D762FEB.3010003@acn-group.ch>
Message-ID: <4D870A59.9050004@acn-group.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudhakar,

On 08.03.2011 14:32, Christophe Aeschlimann wrote:
> On 08.03.2011 05:40, Rajashekhara, Sudhakar wrote:
>> Hi Christophe,
>>
>> On Mon, Mar 07, 2011 at 14:10:41, Christophe Aeschlimann wrote:
>>> Hi Sudhakar,
>>>
>>> On 17.02.2011 05:23, Rajashekhara, Sudhakar wrote:
>>>>
>>>> Reverting the commit 140176159597ea1f23dcccb47b5c38fdf7c7faa8
>>>> (ASoC: Configure symmetric rates for tlv320aic3x) resolves the issue. 
>>>> We are still working on the proper fix.
>>>>
>>>> Thanks,
>>>> Sudhakar
>>>>
>>>
>>> Did you find a proper solution to that issue ?
>>>
>>
>> Did the workaround work for you?
> 
> I'm using the kernel at the following address :
> 
> http://arago-project.org/git/projects/?p=linux-omapl1.git
> 
> And this kernel doesn't have the symmetric rate patch so it must come
> from somewhere else.
> 
> Best regards,
> 
> Christophe

Sorry to have bothered you with this.

In this end it was a HW issue.

Problem solved.

Best Regards,

Christophe

-- 
Christophe Aeschlimann

Embedded Software Engineer & IT Manager

ACN Advanced Communications Networks S.A.

Rue du Puits-Godet 8a
2000 Neuch?tel, Switzerland

T?l. +41 32 724 74 31

c.aeschlimann at acn-group.ch
