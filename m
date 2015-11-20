From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 19:24:50 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] ARM: dts: sun5i: Add i2c axp152
 pmic support for Auxtek T004 boards
In-Reply-To: <20151120164235.GJ32142@lukather>
References: <1448027950-14629-1-git-send-email-hdegoede@redhat.com>
 <1448027950-14629-4-git-send-email-hdegoede@redhat.com>
 <20151120164235.GJ32142@lukather>
Message-ID: <564F6572.2070909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20-11-15 17:42, Maxime Ripard wrote:
> On Fri, Nov 20, 2015 at 02:59:10PM +0100, Hans de Goede wrote:
>> From: Michael van Slingerland <michael@deviousops.nl>
>>
>> Add a node describing the AXP152 pmic used on Auxtek T004 boards.
>>
>> Signed-off-by: Michael van Slingerland <michael@deviousops.nl>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> I don't really get why this patch is in the same set as the other
> patches, but I just applied it. Thanks!

The theme of the set was dts patches which do not depend on anything
else :)

And sorry about the conflicts, I had the touchscreen patches in my
tree before this set.

Regards,

Hans
