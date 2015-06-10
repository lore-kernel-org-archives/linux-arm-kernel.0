From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 10 Jun 2015 15:27:08 +0200
Subject: [PATCH 00/20] ARM: dts: Add USB and OTG related nodes and enable
 on various boards
In-Reply-To: <20150608100358.GW23777@lukather>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
 <20150608100358.GW23777@lukather>
Message-ID: <55783B2C.3080207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08-06-15 12:03, Maxime Ripard wrote:
> Hi Hans,
>
> On Fri, Jun 05, 2015 at 09:02:03PM +0200, Hans de Goede wrote:
>> Hi Maxime,
>>
>> Here is a patch-set with all the otg / sun8i-usb-host related dts patches
>> I've accumulated.
>>
>> These are intended for 4.3, and go hand in hand with the outstanding
>> musb-sunxi / phy-sun4i-usb patches, which I expect to be merged as is
>> for 4.3 .
>
> I'm fine with these patches. Do you have a branch somewhere that I can
> pull (without the one that you wanted me to drop, obviously)?

I've just created a branch with just these patches directly on top
of sunxi/for-next for you:

https://github.com/jwrdegoede/linux-sunxi/commits/otg-dts-for-maxime

While preparing this branch I noticed that the dts for
the ippo q8h a33 tablets is not yet merged:

http://www.spinics.net/lists/devicetree/msg82149.html

You suggested to use the DT quirks interface instead of creating
a separate dts for each board variant, and in the end I agreed,
and asked you to merge it renamed to a more generic name
without the lcd1024x600 bit in there.

I can make it more generic and resend it myself. Do you want me
to squash in the otg changes when I resend it, or shall I keep
those separate ?

Regards,

Hans
