From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 16 Jan 2015 15:16:43 +0800
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: enable more USB functions
In-Reply-To: <20141008114557.GA3830@dragon>
References: <1412060581-13963-1-git-send-email-peter.chen@freescale.com>
 <20141008114557.GA3830@dragon>
Message-ID: <CAL411-qSHS7eg_4Z60TT3euy7BVH5MBmt81DwNJvvvWM_UNsRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 8, 2014 at 7:46 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Tue, Sep 30, 2014 at 03:03:01PM +0800, Peter Chen wrote:
>> USB Ethernet function at host mode
>> USB Media function(webcam) at host mode
>> USB Audio function at host mode
>> USB Serial function at host mode
>> USB EHSET driver at host mode (for OTG & EH Certification test)
>> Several USB Gadget functions:
>>       - Configfs
>>       - NCM
>>       - Zero (used for test)
>>       - Gadgetfs
>>       - Serial
>>
>> Above functions are built as module.
>>
>> Signed-off-by: Peter Chen <peter.chen@freescale.com>
>
> Applied, thanks.
>

Hi Shawn,

It seems this patch is missed by unknown reason, I can't find it at
current mainline.



-- 
BR,
Peter Chen
