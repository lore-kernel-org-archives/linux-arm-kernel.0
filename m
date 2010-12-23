From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Thu, 23 Dec 2010 17:59:40 +0100
Subject: [PATCH] ARM: colibri-pxa300: use correct SD detect pin
In-Reply-To: <201012231715.36442.marek.vasut@gmail.com>
References: <1293116462-10189-1-git-send-email-bjorn.forsman@gmail.com>
	<201012231715.36442.marek.vasut@gmail.com>
Message-ID: <AANLkTik-ZE-9mvZ7PN1QZx8OJpHcynNz6-0RqcTS=x+y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

2010/12/23 Marek Vasut <marek.vasut@gmail.com>:
> On Thursday 23 December 2010 16:01:02 Bj?rn Forsman wrote:
>> The use of wrong SD detect pin was introduced by this commit:
>>
>> ? ARM: pxa: Push Colibri evalboard MFP into module files
>>
>> This fixes it.
>
> Ah, one more thing -- CC linux-arm-kernel (done)

I didn't CC linux-arm-kernel because the patch was meant for
Eric Miao's pxa-linux-2.6.git tree (devel branch). I doesn't apply
to mainline.

As Eric anyways uses 'git rebase' on his tree every -rc cycle
I suggested that he could squash my patch into your original
patch so that we get nice bisectable history.

Best regards,
Bj?rn Forsman
