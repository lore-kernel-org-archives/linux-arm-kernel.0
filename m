From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 8 Feb 2016 18:34:59 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Enable USB DRC on Itead Ibox
In-Reply-To: <CAEKpxBkXp9hx6KWpWyRBvYBFi7Sr0FgFHrD6M0nSBuJ1bV++1A@mail.gmail.com>
References: <1454947167-12236-1-git-send-email-codekipper@gmail.com>
 <56B8BED7.9030704@redhat.com>
 <CAEKpxBkXp9hx6KWpWyRBvYBFi7Sr0FgFHrD6M0nSBuJ1bV++1A@mail.gmail.com>
Message-ID: <56B8D1C3.809@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-02-16 17:56, Code Kipper wrote:
> On 8 February 2016 at 17:14, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 08-02-16 16:59, codekipper at gmail.com wrote:
>>>
>>> From: Marcus Cooper <codekipper@gmail.com>
>>>
>>> Enable the otg/drc usb controller on the Itead Ibox device.
>>>
>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>>
>>
>> Same remark as with your Olimex A20 EVB board patch, please
>> also provide a vbus detect pin setting. If for some reason the
>> VBus detect is not wired up, or not working properly, please mention
>> this explicitly in the commit message.
> Hi Hans,
> I've added vbus detect and it no longer works. It's mentioned that the
> Itead Ibox is similar to the Cubieboard 2 which also doesn't include
> the detect. I can see now in the commit that it states "Note this
> board has the otg-vbus connected directly to the 5v-dcc of the board,
> so there is no vbus0 regulator, nor vbus0-det.", I will add this to
> the commit message and try and dig out a schematic to confirm.

Ok, thanks for looking into this.

Regards,

Hans
