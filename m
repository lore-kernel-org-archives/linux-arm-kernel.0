From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Feb 2016 13:23:52 -0800
Subject: [PATCH V2 03/12] dtb: amd: Fix DMA ranges in device tree
In-Reply-To: <56BBA80E.6090205@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1454954357-8395-4-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2845776.WTPtnQzg8d@wuerfel> <56BBA80E.6090205@amd.com>
Message-ID: <CAOesGMgOmmXY2X2bwOd-6m117o6VPpqer6BXrzNePuRPoiz_Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 10, 2016 at 1:13 PM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
> Hi Arnd,
>
>
> On 2/9/16 21:57, Arnd Bergmann wrote:
>>
>> On Monday 08 February 2016 11:59:08 Suravee Suthikulpanit wrote:
>>>
>>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>
>>> Fix DMA ranges of smb0 and pcie0 nodes in AMD Seattle SOC.
>>>
>>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>>
>>
>> This could use a changelog text to explain why it's broken and how the
>> fix works.
>>
>>         Arnd
>>
>
> So, I have not experience the breakage. However, IIUC, the GICv2m MSI frame
> is also considered DMA-able. So, I think it should be included in the
> dma-range specified here. Please let me know if my assumption is incorrect.
> Otherwise, I will include more description in the commit log in my next rev.

As I replied when I did it -- I've applied the patches, so respinning
won't work. Instead, please follow up with incremental fixes to this
series instead.


Thanks,

-Olof
