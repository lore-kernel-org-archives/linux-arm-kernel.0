From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 02 Jan 2014 10:37:47 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <20140101205603.GA1141@core.coreip.homeip.net>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <1388604610-20380-2-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
Message-ID: <52C5336B.9010903@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/01/2014 09:56 PM, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Wed, Jan 01, 2014 at 08:30:07PM +0100, Hans de Goede wrote:
>> +Required properties:
>> + - compatible: "allwinner,sun4i-lradc-keys"
>> + - reg: mmio address range of the chip
>> + - interrupts: interrupt to which the chip is connected
>> + - allwinner,chan0-step: step in mV between keys must be 150 or 200
>> + - allwinner,chan0-keycodes: array of include/uapi/linux/input.h KEY_ codes
>
> I think this should be "linux,chan0-keycodes".

Right, because the codes are Linux specific, will fix in v2.

Regards,

Hans
