From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 14 May 2010 18:39:05 +0200
Subject: [PATCH] MXC: Add USB OTG (device) for i.MX31 PDK (3DS) board.
In-Reply-To: <337730.29882.qm@web51003.mail.re2.yahoo.com>
References: <1273849709-870-1-git-send-email-lilja.magnus@gmail.com>
	<337730.29882.qm@web51003.mail.re2.yahoo.com>
Message-ID: <AANLkTikVnW1eBjLTBsNT-H_Z9RHJrcdzVsU7xGA8gcsc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

On 14 May 2010 18:00, Fabio Estevam <fabioestevam@yahoo.com> wrote:
> Hi Magnus,
>
> --- On Fri, 5/14/10, Magnus Lilja <lilja.magnus@gmail.com> wrote:
>
>> From: Magnus Lilja <lilja.magnus@gmail.com>
>> Subject: [PATCH] MXC: Add USB OTG (device) for i.MX31 PDK (3DS) board.
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: s.hauer at pengutronix.de
>> Date: Friday, May 14, 2010, 12:08 PM
>> Tested on actual hardware using the
>> g_ether and g_serial gadget drivers.
>>
>> Signed-off-by: Magnus Lilja <lilja.magnus@gmail.com>
>> ---
>>
>> Applies on top of Linus' git tree.
>> To test this the mx3_defconfig was used but with USB gadget
>> activated.
>
> Would be good to send a patch for updating the mx3_defconfig with the USB gadget support.

Yes, perhaps that can be done later when bringing the defconfig
uptodate (also awaiting inclusion of Alberto Panizzo's keypad patch).

Regards, Magnus Lilja
