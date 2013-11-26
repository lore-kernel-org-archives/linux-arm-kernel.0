From: nm@ti.com (Nishanth Menon)
Date: Tue, 26 Nov 2013 16:15:10 -0600
Subject: [PATCH v3 09/10] ARM: dts: omap3-beagle-xm: Add USB Host support
In-Reply-To: <20131126210456.GN26766@atomide.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
 <1380012836-29900-10-git-send-email-rogerq@ti.com>
 <528BD2AF.2030607@ti.com> <528C8FBC.7020407@ti.com>
 <20131126210456.GN26766@atomide.com>
Message-ID: <CAGo_u6r63oQ0tKrB4G_CK7Vpd5XOsVE+N-HEdiRYP41U5FsEhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 3:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Roger Quadros <rogerq@ti.com> [131120 02:33]:
>> Nishant,
>>
>> On 11/19/2013 11:05 PM, Nishanth Menon wrote:
>> >
>> >
>> > On 09/24/2013 03:53 AM, Roger Quadros wrote:
>> >> Provide RESET GPIO and Power regulator for the USB PHY,
>> >> the USB Host port mode and the PHY device for the controller.
>> >> Also provide pin multiplexer information for USB host pins.
>> >>
>> >> We also relocate omap3_pmx_core pin definations so that they
>> >> are close to omap3_pmx_wkup pin definations.
>> >>
>> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> >> ---
>> >
>> > just using this thread, but a question ->
>> >
>> > I am kernel * master                                   dec8e46 Merge
>> > tag 'arc-v3.13-rc1-part2' of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc
>> >
>> > and I see that VAUX2 which supplies USB_1V8[1] is not enabled -> I did
>> > a quick patch and it did seem to work (Usb keyboard, networking, mouse
>> > etc on my ehci ports seems to come up good) - any suggestions how we'd
>> > like to handle this?
>>
>> It worked for me without your patch. It could be that u-boot is enabling
>> that regulator for me. I'm on u-boot-v2013.10.
>>
>> In any case, your patch seems the right thing to do. We should take it in
>> the rc cycle.
>
> Can you guys post a proper fix for this? Meanwhile, I'll mark this
> thread as read to shrink my inbox a bit.
already done:
https://patchwork.kernel.org/patch/3231151/
