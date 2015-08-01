From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 1 Aug 2015 09:43:24 +0200
Subject: [PATCH v3 1/4] ARM: dts: Add binding documentation for AXP20x
 pmic usb power supply
In-Reply-To: <20150724145928.GG27569@earth>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <20150724145928.GG27569@earth>
Message-ID: <55BC789C.4020205@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-07-15 16:59, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 12:59:14PM +0200, Hans de Goede wrote:
>> Add binding documentation for the usb power supply part of the AXP20x pmic.
>> [...]
>> +Example:
>> +
>> [...]
>> +
>> +	usb_power_supply: usb_power_supply {
>                        ^^^^^^^^^^^^^^^^
>                        use usb-power-supply here.

Ok, fixed for the upcoming v4 of the power-supply part of this patch set.

Regards,

Hans
