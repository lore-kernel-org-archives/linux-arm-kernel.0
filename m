From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 20 May 2014 14:22:57 +0200
Subject: [PATCH] ARM: sun6i: Enable USB Host support on the Colombus board
In-Reply-To: <20140520121657.GG27329@lukather>
References: <1400587155-19387-1-git-send-email-maxime.ripard@free-electrons.com>
 <537B4587.5020803@redhat.com> <20140520121657.GG27329@lukather>
Message-ID: <537B4921.1020804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/20/2014 02:16 PM, Maxime Ripard wrote:
> Hi,
> 
> On Tue, May 20, 2014 at 02:07:35PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05/20/2014 01:59 PM, Maxime Ripard wrote:
>>> The colombus board has a on-board USB hub, that is enabled through the pin
>>> PH24, and wired to the first EHCI controller.
>>
>> ehci0 is not hooked up at all on this board ? I would expect it to go to
>> a usb wifi card for example.
>>
>> Assuming that ehci0 is not hooked up, this is:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> It's unclear, because the schematics say that we have two options,
> either USB or SDIO wifi chips.
> 
> However, looking at the boards, it looks like it's the latter.

Ok.

Regards,

Hans
