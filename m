From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 13 Feb 2013 06:24:14 -0300
Subject: [PATCH v2 0/4] ARM: mvebu: Add support for SPI flash devices in
 Armada 370/XP
In-Reply-To: <20130206132850.GC14746@titan.lakedaemon.net>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <511257C6.2070604@free-electrons.com>
 <20130206132850.GC14746@titan.lakedaemon.net>
Message-ID: <CALF0-+WLh=8QGG4ob8HVq+x4oO_ArdFHd=vH1_OhucH1f9XG3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Wed, Feb 6, 2013 at 10:28 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Feb 06, 2013 at 02:16:54PM +0100, Gregory CLEMENT wrote:
>> On 02/06/2013 02:06 PM, Ezequiel Garcia wrote:
>> > This is second version of the SPI patchset for Armada 370/XP.
>> >
>> > This series first adds support for the SPI controller
>> > and then adds the SPI flash for the Armada XP GP board.
>> >
>> > This series is based on 3.8-rc5 plus:
>> >  * "arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"
>> >  * "arm: mvebu: i2c come back in defconfig"
>> >
>> > Feel free to test or provide any feedback!
>> >
>> Ezequiel,
>>
>> I reviewed the patches, I have nothing more to say, I can add my:
>>
>> Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
>>
>> on the patch that didn't have yet.
>>
>> Jason,
>> could you add this series in your incoming pull request?
>
> That's the plan.  I'm waiting for a response from Olof to see If I need
> to redo /boards and /dt.  In either case, my next round of pull requests
> with have this and a bunch of other stuff.
>

Despite we're almost closed for v3.9 new material,
I hope you don't mind a little ping on the USB and SPI stuff.

I'd *really* love to see these in v3.9, if at all possible.

Thanks,

-- 
    Ezequiel
