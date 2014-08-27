From: olof@lixom.net (Olof Johansson)
Date: Tue, 26 Aug 2014 19:27:53 -0700
Subject: [PATCH v2 0/5] ARM: shmobile: correct memory maps
In-Reply-To: <CANqRtoTSxB3GQoYg6ecpKQ4N7JO2ahotjaAL3oEebE1h3PGtZg@mail.gmail.com>
References: <1409099726-21814-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTSxB3GQoYg6ecpKQ4N7JO2ahotjaAL3oEebE1h3PGtZg@mail.gmail.com>
Message-ID: <CAOesGMiZPNkpoe1UJ0VG0yL1qHq-q7OOQUrJSdw_Z0sVFgDcwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 6:45 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi Simon,
>
> On Wed, Aug 27, 2014 at 9:35 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
>> This short series builds on a previous posting
>> of a patch to correct the value of the second memory region
>> of the lager. It does that and also corrects the syntax
>> used for the lager and other shmobile boards.
>>
>> Simon Horman (5):
>>   ARM: shmobile: lager: correct memory map value and syntax
>>   ARM: shmobile: henninger: correct memory map syntax
>>   ARM: shmobile: koelsch: correct memory map syntax
>>   ARM: shmobile: ape6evm-reference: correct memory map syntax
>>   ARM: shmobile: ape6evm: correct memory map syntax
>
> Thanks for improving the current state. The patches look fine to me.
>
> Acked-by: Magnus Damm <damm+renesas@opensource.se>

Yep, agreed.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
