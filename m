From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 10 Oct 2011 13:56:19 +0200
Subject: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
In-Reply-To: <CAC83ZvLd27nER5z1R1L27KFR4CQ1mwhmQ18BR7OCBZEDtNFWYg@mail.gmail.com>
References: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
	<4E8B7C6A.2050207@ti.com>
	<CAC83Zv+r0emW7rREkPhjPyn_jBCbNLXKCNTY0=vMNxCTzzp=Xg@mail.gmail.com>
	<CAC83ZvLd27nER5z1R1L27KFR4CQ1mwhmQ18BR7OCBZEDtNFWYg@mail.gmail.com>
Message-ID: <4E92DD63.6090906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2011 12:05 PM, DebBarma, Tarun Kanti wrote:
> On Mon, Oct 10, 2011 at 11:10 AM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com>  wrote:
>> On Wed, Oct 5, 2011 at 3:06 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> Hi Tarun,
>>>
>>> On 10/4/2011 11:20 PM, Cousson, Benoit wrote:
>>>>
>>>> Hi Tony,
>>>>
>>>> Here is the series to fix the warning and remove the redundant
>>>> latency structure that be removed since the timer runtime PM
>>>> adaptation was just pulled.
>>>>
>>>> I was just able to test that on OMAP4.
>>>
>>> It will be nice if you can test that on the other platforms.
>>> In theory, if they are properly using hwmod that should work fine.
>> Yes, I will test in other platforms.
> I have tested on OMAP2420, OMAP2430 and OMAP3430.

Thanks Tarun,

Regards,
Benoit
