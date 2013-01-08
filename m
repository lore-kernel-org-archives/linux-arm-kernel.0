From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 8 Jan 2013 16:32:41 +0800
Subject: [V2 PATCH 00/27] mv-usb fix and enhancement patches
In-Reply-To: <CADApbei1BsSOyBkRLQo8gLJvOzyDJ5eeKQ6Gqk-ycXCgEEsNnQ@mail.gmail.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
 <20121130141012.GA17587@arwen.pp.htv.fi>
 <CAN1soZw=Zz8vuwbEnH4L2yHyjpOYopH8s=GxRdaXyKZuh8ZaqQ@mail.gmail.com>
 <CADApbei1BsSOyBkRLQo8gLJvOzyDJ5eeKQ6Gqk-ycXCgEEsNnQ@mail.gmail.com>
Message-ID: <CADApbeg06Wq0VQcrgmTU0i6mJz=5BZ48vD2xzh3bHbDVTbog7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 5, 2013 at 9:35 AM, Chao Xie <xiechao.mail@gmail.com> wrote:
> hi, Felipe
> How about these patches? i see that 3.8-rc2 is tagged but these
> patches are not merged. Thanks.
>
> On Tue, Dec 4, 2012 at 3:34 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>> On Fri, Nov 30, 2012 at 10:10 PM, Felipe Balbi <balbi@ti.com> wrote:
>>> Hi,
>>>
>>> On Tue, Nov 27, 2012 at 10:05:59PM -0500, Chao Xie wrote:
>>>> The patches are divied into 4 parts
>>>> 1. bug fixes
>>>>   usb: gadget: mv_udc: use udc_start and udc_stop functions
>>>>   usb: gadget: mv_udc: use devm_xxx for probe
>>>>   usb: gadget: mv_udc: fix the clk APIs
>>>>   usb: otg: mv_otg: use devm_xxx for probe
>>>>   usb: otg: mv_otg: fix the clk APIs
>>>>   usb: host: ehci-mv: fix clk APIs
>>>>   usb: host: ehci-mv: remove unused variable
>>>>   usb: gadget: mv_udc: fix the value of tranceiver
>>>> Above patches are bug fixes.
>>>
>>> The gadget and OTG parts I will start queueing once v3.8-rc1 is tagged,
>>> please hang on.
>>>
>>> --
>>> balbi
>>
>> Acked for all patches in arch-mmp.

hi, Felipe
How about the patches for
2. PHY driver
3. external chip support?
Do i need re-submit the patches? Thanks.
