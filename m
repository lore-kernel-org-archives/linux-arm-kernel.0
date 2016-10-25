From: eric@anholt.net (Eric Anholt)
Date: Tue, 25 Oct 2016 08:44:00 -0700
Subject: [PATCH 3/5] staging/vchi: Fix some pointer math for 64-bit.
In-Reply-To: <20161025075515.GA29765@kroah.com>
References: <20161017194406.1080-1-eric@anholt.net>
 <20161017194406.1080-4-eric@anholt.net> <20161025075515.GA29765@kroah.com>
Message-ID: <87oa281lj3.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Mon, Oct 17, 2016 at 12:44:04PM -0700, Eric Anholt wrote:
>> These were throwing warnings on aarch64, and all are trivially
>> converted to longs.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 6 +++---
>>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c     | 5 +++--
>>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> This didnt apply anymore as I think I took the other fixups, sorry.

No problem, I'm happy to see Michael's stuff getting merged.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/36d2d692/attachment-0001.sig>
