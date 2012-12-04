From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 4 Dec 2012 13:10:16 +0200
Subject: linux-next: manual merge of the arm-soc tree with the iommu tree
In-Reply-To: <20121204110655.GE18368@8bytes.org>
References: <20121204154203.f0e7e87d1ae99e5c528434f8@canb.auug.org.au>
 <20121204110655.GE18368@8bytes.org>
Message-ID: <CAK=WgbYDKN1deDTw3KvymvhoE1h_apX2E8zK=cDbu68+Gwcayw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 4, 2012 at 1:06 PM, Joerg Roedel <joro@8bytes.org> wrote:
> On Tue, Dec 04, 2012 at 03:42:03PM +1100, Stephen Rothwell wrote:
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> arch/arm/mach-omap2/clock44xx_data.c between commit 298ea44f211d ("ARM:
>> OMAP4: hwmod data: ipu and dsp to use parent clocks instead of leaf
>> clocks") from the iommu tree and commit 13a5b6228679 ("ARM: OMAP44xx:
>> clock: drop obsolete clock data") from the arm-soc tree.
>>
>> I just deleted the file as the latter did and can carry the fix as
>> necessary (no action is required).
>
> Ohad, Omar, any comment on this?

I'd prefer Omar or Paul to have a look here. Looping in Tony as well.

Ohad.
