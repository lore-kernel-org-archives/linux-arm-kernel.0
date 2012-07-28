From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 23:28:15 +0800
Subject: [PATCH 2/6] pinctrl: add pinconf support in pxa3xx
In-Reply-To: <5013BD67.7020907@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-3-git-send-email-haojian.zhuang@gmail.com>
 <5013BD67.7020907@gmail.com>
Message-ID: <CAN1soZxXF064Gb+8uQTs0d0KphG7T8T=vZcV92ac9Gtf8Sr_eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 6:22 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 28.07.2012 08:58, Haojian Zhuang wrote:
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>  drivers/pinctrl/pinctrl-pxa3xx.c |  189 ++++++++++++++++++++++++++++++++++++++
>>  drivers/pinctrl/pinctrl-pxa3xx.h |   17 ++++
>>  2 files changed, 206 insertions(+)
>
> As I'm working on a PXA3xx platform currently that already fully boots
> from DT, I'd like to give this series a try.
>
> But I wonder if this is supposed to be fully working yet, because that
> code won't be compiled for PXA3xx as long as PINCTRL isn't set for that
> platform (arch/arm/mach-pxa/Kconfig).
>
>
> Daniel
>
>
pinctrl-pxa3xx.c is the common code for those PXA silicons. But I didn't add
the pxa300/pxa310/pxa320 pin support yet. Now I only support pxa168/pxa910/
mmp2 silicon.

Regards
Haojian
