From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 25 Sep 2018 12:48:09 +0200
Subject: [PATCH v2 00/22] Unify MediaTek pinctrl in preparation for MT8183
 and MT6765
In-Reply-To: <1537503761.9654.17.camel@mtkswgap22>
References: <cover.1536404280.git.sean.wang@mediatek.com>
 <CACRpkdZtVBjYGs5C7-HWEyX7f7pnCqvnRYBH=fFmLKhN4FGymA@mail.gmail.com>
 <1537325650.572.9.camel@mtkswgap22> <20180919043722.GA14181@Mani-XPS-13-9360>
 <1537503761.9654.17.camel@mtkswgap22>
Message-ID: <9f0a8868-a06e-d378-1008-df758b898fbe@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/09/2018 06:22, Sean Wang wrote:
> On Tue, 2018-09-18 at 21:37 -0700, Manivannan Sadhasivam wrote:
>> On Wed, Sep 19, 2018 at 10:54:10AM +0800, Sean Wang wrote:
>>> On Tue, 2018-09-18 at 15:07 -0700, Linus Walleij wrote:
>>>> On Sat, Sep 8, 2018 at 4:07 AM <sean.wang@mediatek.com> wrote:
>>>>
>>>>> v2 and changes since v1:
>>>>
>>>> I had trouble applying the last patches in the series so I applied
>>>> all on an immutable branch (ib-mtk) then merged that into devel
>>>> and added a patch on top to fix up some GPIO includes (just sent).
>>>>
>>>> Please check the result!
>>>>
>>>
>>> Sure, I'll take a look and and test on the devel branch.
>>>
>>> On the top, I'll add a fix for the issue recently reported by kbuild
>>> test robot about implicit declaration and a new MT6765 driver based
>>> on the series.
>>>
>>
>> Hi Sean,
>>
>> Do you have any plans to add support for MT6797?
>>
> 
> I personally have no the plan to add support to MT6797 because I have no
> the device, but as I knew some of people in mediatek have interest to
> add them by volunteers and thus there is no clear schedule. Eventually,
> if they're really done, they would be still based on vendor binding not
> by generic binding.
> 

CCing Saber as he is working on the pinctrl for this device. Actually he as some
questions regarding the register layout.

Sean maybe you can bring him in contact with someone inside Mediatek who could
help him :)

Regards.
Matthias
