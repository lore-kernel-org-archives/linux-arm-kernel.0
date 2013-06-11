From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 11 Jun 2013 18:33:15 +0900
Subject: [PATCH v2] ARM: shmobile: uImage load address rework
In-Reply-To: <20130611074713.GB10440@verge.net.au>
References: <20130610092857.19175.25629.sendpatchset@w520>
 <20130611074713.GB10440@verge.net.au>
Message-ID: <CANqRtoQGrOor4n9p4u=SR=RTLTM2LfJ_jxxviy3yh=LTrsQLYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 4:47 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Jun 10, 2013 at 06:28:57PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This is V2 of the mach-shmobile uImage load address rework patch.
>>
>> Rework the mach-shmobile uImage load address calculation by storing
>> the per-board load addresses in Makefile.boot. This removes the
>> CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
>> it possible to create safe kernel images that boot on multiple boards.
>>
>> This is one of several series of code that reworks code not to rely on
>> CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Thanks, I have queued this up in the soc2 branch.
> My current plan is to let that branch sit in next for a few
> days and then send a pull-request for it to be included in v3.11.

Sounds good, thanks! I will try to sort out the remaining bits and see
where that takes us.

Cheers,

/ magnus
