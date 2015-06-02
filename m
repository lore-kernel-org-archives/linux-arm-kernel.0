From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 02 Jun 2015 20:32:59 +0200
Subject: [PATCH] ARM: dts: sun6i: Add a dts file for the Mele A1000G quad
 top set box
In-Reply-To: <20150602155816.GC23777@lukather>
References: <1433170979-13725-1-git-send-email-hdegoede@redhat.com>
 <20150602155816.GC23777@lukather>
Message-ID: <556DF6DB.8040601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/02/2015 05:58 PM, Maxime Ripard wrote:
> On Mon, Jun 01, 2015 at 05:02:59PM +0200, Hans de Goede wrote:
>> The Mele A1000G-quad and the Mele M9 have the same PCB, sofar we've been using
>> the same dts for both models. Unfortunately this does not work for the otg
>> controller, on the M9 this is routed to a micro-usb connector on the outside,
>> while as on the A1000G-quad it is connected to an usb to sata bridge
>> (which is not populated on the M9 pcb).
>>
>> This commit adds a new dts for the Mele-A1000G-quad to allow using
>> different otg controller settings on the 2 boards.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   arch/arm/boot/dts/Makefile                                        | 1 +
>>   arch/arm/boot/dts/{sun6i-a31-m9.dts => sun6i-a31-a1000g-quad.dts} | 4 ++--
>
> Didn't we say that we were trying to set the vendor name in the DTs
> now, at least for the new ones?

I think we said that Paul would write a proposal to standardize
naming for future boards, but that never materialized.

> I can fix this and apply it if it's ok for you.

I'm fine with throwing -mele- in there, or not, what ever you
prefer.

Regards,

Hans

>
> Maxime
>
