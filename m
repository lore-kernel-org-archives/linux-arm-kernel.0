From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 5 Jul 2016 09:08:04 +0200
Subject: [PATCH v6 0/1] phy-sun4i-usb: Add support for peripheral-only mode
In-Reply-To: <577B485C.8010300@ti.com>
References: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
 <577B485C.8010300@ti.com>
Message-ID: <c3249b24-93e4-8b40-4279-d2ad37aaea99@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05-07-16 07:40, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Tuesday 05 July 2016 02:47 AM, Hans de Goede wrote:
>> Hi Kishon,
>>
>> Thanks for merging one of the 2 pending phy-sun4i-usb patches, I see
>> that the other one actually has a conflict after merging in
>> linux-phy/fixes. So here is a rebased version of it.
>>
>> Note can you please make sure this gets into 4.8? I've a musb patch
>> ("usb: musb: sunxi: Simplify dr_mode handling") heading into 4.8,
>> which depends on the changes in this patch to keep host-only mode
>> working (runtime dependency) and we do use host-only mode on a few
>> boards.
>
> sure.. but I think this patch can go only in the -rc cycle because of
> of_usb_get_dr_mode_by_phy() API taking 2 arguments.

Ok, thanks.

Regards,

Hans
