From: loic.pallardy@st.com (Loic PALLARDY)
Date: Wed, 13 Feb 2013 21:36:39 +0100
Subject: [PATCH v2 00/13] drivers: mailbox: framework creation
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C50476638@DLEE12.ent.ti.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
 <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
 <20130213134207.GN17852@n2100.arm.linux.org.uk>
 <37C860A02101E749A747FA2D3C1E3C50476638@DLEE12.ent.ti.com>
Message-ID: <511BF957.4010501@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

I'll send new version of patch 11 taking into account Mark Rutland's 
comments.

Regards,
Loic

On 02/13/2013 05:41 PM, Anna, Suman wrote:
>> On Wed, Feb 13, 2013 at 02:36:32PM +0100, Linus Walleij wrote:
>>> On Tue, Feb 12, 2013 at 5:56 AM, Suman Anna<s-anna@ti.com>  wrote:
>>>
>>>> I have hosted the series at [3].
>>>> [3]
>>>> https://github.com/sumananna/mailbox/commits/dbx500-prcmu-mailbox
>>>
>>> Suman, I suggest you ask Stepgen Rothwell to include this branch into
>>> the linux-next tree, so we can get some rotation of this stuff in
>>> preparation for the v3.10 merge window. (It's not going in now
>>> anyway.)
>>
>> Best wait until after v3.9-rc1 - remember that linux-next is supposed to be a
>> staging tree for the _next_ merge window only.
>
> Yes, will do. Anyway, we need a new revision of one patch (so far) to address Mark Rutland's comments.
>
> Thanks
> Suman
