From: yegorslists@googlemail.com (Yegor Yefremov)
Date: Wed, 29 May 2013 12:06:52 +0200
Subject: [PATCH v2] usb: musb: fix clock naming
In-Reply-To: <20130528173637.GE15794@arwen.pp.htv.fi>
References: <1369725661-3114-1-git-send-email-yegorslists@googlemail.com>
 <20130528173637.GE15794@arwen.pp.htv.fi>
Message-ID: <CAGm1_ks7Y8n1xKA=qiCCFcxgydRiyeJS08A8TPnbnEEmkJxVyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 7:36 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, May 28, 2013 at 09:21:01AM +0200, yegorslists at googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> 'ick' was changed to 'hsotgusb_ick'
>> 'fck' was changed to 'hsotgusb_fck'
>>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>
> NAK. Fix your clock data.

Do you mean here arch/arm/mach-omap2/cclock3xxx_data.c?

Yegor
