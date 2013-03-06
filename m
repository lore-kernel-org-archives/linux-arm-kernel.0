From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 6 Mar 2013 10:46:56 -0600
Subject: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
In-Reply-To: <CALF0-+VeU9tGy-dKgmVg1pT0z0ghJBSsughV7kzT5nX7u=9BhA@mail.gmail.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-12-git-send-email-jon-hunter@ti.com>
 <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com>
 <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <513664EC.2050508@ti.com>
 <CALF0-+VeU9tGy-dKgmVg1pT0z0ghJBSsughV7kzT5nX7u=9BhA@mail.gmail.com>
Message-ID: <51377300.3040809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/06/2013 05:58 AM, Ezequiel Garcia wrote:
> Jon,
> 
> On Tue, Mar 5, 2013 at 6:34 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>> By the way, with this version you should remove "simple-bus" from your
>> gpmc node compatible strings. I now call of_platform_device_create() to
>> create the child device during the GPMC probe. I think that this is a
>> safer approach.
>>
> 
> FWIW, using of_platform_device_create() works for my driver.
> It seems as simple as using a compatible 'simple-bus',
> with the advantage that it allows to create and probe the
> child device from its parent.

Yes and I think that is safer for these type of drivers.

> I'll submit this driver by the end of this week, in case you want
> to take a look at it.

Ok, but this is not for omap right?

Cheers
Jon
