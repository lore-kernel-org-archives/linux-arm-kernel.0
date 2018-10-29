From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Mon, 29 Oct 2018 19:09:20 +0800
Subject: [PATCH v4 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
In-Reply-To: <20181029104701.1bcdfbf3@xps13>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-3-git-send-email-jianxin.pan@amlogic.com>
 <20181029104701.1bcdfbf3@xps13>
Message-ID: <746f2741-ecce-2242-3711-7c8d56058da9@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On 2018/10/29 17:47, Miquel Raynal wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> wrote
> on Thu, 20 Sep 2018 16:50:49 +0800:
> 
>> From: Liang Yang <liang.yang@amlogic.com>
>>
>> Add initial support for the Amlogic NAND flash controller which found
>> in the Meson-GXBB/GXL/AXG SoCs.
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
> 
> I lost track of what's ongoing there, can you remind me the status of
> the whole clk/nand series?
> 
> If the clock driver is ready, can you resend the NAND controller driver
> please? IIRC it was in a pretty good shape already.
>
We got some suggestions about the clock driver, and we are preparing for the next version.
I will resend it soon.
Thank you.
 

> Thanks,
> Miqu?l
> 
> .
> 
