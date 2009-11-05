From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 5 Nov 2009 11:50:07 +0800
Subject: [PATCH] [ARM] pxa: add U2D registers and bits definitions
In-Reply-To: <f870da180911041406o72fa6890v7209dc86cdd23117@mail.gmail.com>
References: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
	<1257336880-16011-2-git-send-email-grinberg@compulab.co.il>
	<f17812d70911040635o1ab53e64s255d031db0de6091@mail.gmail.com>
	<f870da180911041406o72fa6890v7209dc86cdd23117@mail.gmail.com>
Message-ID: <f17812d70911041950u7d757eb9o2fae148b34814198@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2009 at 6:06 AM, Mike Rapoport <mike.rapoport@gmail.com> wrote:
>
>
> On Wed, Nov 4, 2009 at 4:35 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>
>> On Wed, Nov 4, 2009 at 8:14 PM, Igor Grinberg <grinberg@compulab.co.il>
>> wrote:
>> >
>> > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> > Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> > ---
>> > ?arch/arm/mach-pxa/include/mach/regs-u2d.h | ?199
>> > +++++++++++++++++++++++++++++
>> > ?1 files changed, 199 insertions(+), 0 deletions(-)
>> > ?create mode 100644 arch/arm/mach-pxa/include/mach/regs-u2d.h
>> >
>> > diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h
>> > b/arch/arm/mach-pxa/include/mach/regs-u2d.h
>>
>> Unless there are registers shared between drivers and platform code,
>> I'd rather this been kept closer to the driver, include/mach/* is already
>> pretty crowded :)
>>
> Well, since there's no u2d driver yet it's difficult to keep the register
> defines close to it.
> Unfortunately we are not woking on u2d and OTG support for pxa3xx, but we
> need these register defines to enable at least USB host on CM-X310.
>

Fair enough, applied with a commit comment of the above issue.
