From: fkan@apm.com (Feng Kan)
Date: Thu, 9 Jan 2014 14:51:19 -0800
Subject: [PATCH V2 1/6] Documentation: add dts binding for X-Gene reboot
 dts node.
In-Reply-To: <6073715.cGydpIHKD1@wuerfel>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-2-git-send-email-fkan@apm.com>
 <20140108100549.GE6701@e106331-lin.cambridge.arm.com>
 <6073715.cGydpIHKD1@wuerfel>
Message-ID: <CAL85gmA5Ob+kp-+5seO-wcB8tx4jyiOeFMyCsZWFBLdX09nZDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 2:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 January 2014 10:05:50 Mark Rutland wrote:
>> > +
>> > +Example:
>> > +
>> > +     reboot at 0 {
>> > +             compatible = "apm,xgene-reboot";
>> > +             reg = <0x0 0x17000014 0x0 0x4>;
>> > +     };
>>
>> Given this seems to be a 64-bit address, the unit address should
>> preferably be 0,17000014 rather than just 0.
>
> I also wonder about the size and location of the register.
> Are you sure the device is just a single 4-byte register at offset
> 0x14, rather than a complex device that happens to contain the
> reset register?

FKAN: this is a single 4 byte register when clicked perform the system
reset of the platform.

>
>         Arnd
