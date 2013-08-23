From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 23 Aug 2013 21:29:35 +0530
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <20130824024512.GA2528@gmail.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-4-git-send-email-b32955@freescale.com>
 <CAHSAbzN166J=DFi+1koPUpnFpJVHwtbC1AP21ywhAAissQxPxg@mail.gmail.com>
 <52172A81.5090501@freescale.com> <52173217.70505@ti.com>
 <20130824024512.GA2528@gmail.com>
Message-ID: <521786E7.3070201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 August 2013 08:15 AM, Huang Shijie wrote:
> On Fri, Aug 23, 2013 at 03:27:43PM +0530, Sourav Poddar wrote:
>> On Friday 23 August 2013 02:55 PM, Huang Shijie wrote:
>>> ? 2013?08?23? 17:05, yuhang wang ??:
>>>
>> You should add QOR opcodes also in your patch, so we have the complete set.
> yes, i have already supported the QIOR opcode in my driver.
>
I meant opcode 0x6b Quad output read which spansion flash supports.
> thanks
> Huang Shijie
