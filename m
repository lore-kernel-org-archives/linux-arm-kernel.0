From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Mon, 16 May 2011 19:25:11 +0300
Subject: [PATCHv2 0/2] [RFC] Shrink clock data utilizing preprocessor
In-Reply-To: <20110516075618.GC2429@pengutronix.de>
References: <1305495958-2236-1-git-send-email-vzapolskiy@gmail.com>
	<20110516075618.GC2429@pengutronix.de>
Message-ID: <BANLkTi=UE1YwBC3_Cd-Qo1YpGnLpjGWW5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, May 16, 2011 at 10:56 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Vladimir,
>
> On Mon, May 16, 2011 at 12:45:56AM +0300, Vladimir Zapolskiy wrote:
>> This change shows a possibility to utilize C preprocessor to remove
>> redundant data from clock definitions for OMAP4 architecture.
>>
>> If the change is evaluated as a positive one, the same approach could
>> be applied in reducing LOCs from other files, which contain monotonous
>> data enumeration.
>>
>> Vladimir Zapolskiy (2):
>> ? OMAP4: clock data: shrink clock data utilizing preprocessor.
>> ? OMAP4: clock data: shrink more clock data.
>>
>> ?arch/arm/mach-omap2/clock44xx_data.c | 3313 +++++++++-------------------------
>> ?1 files changed, 848 insertions(+), 2465 deletions(-)
>
> While the diffstat shows a huge saving in loc I suggest to delay this
> until we have common clock code merged so that we don't have to
> completely rework these files again in the near future.
>
> This has been said before, I just wanted to add my +1 on this opinion.

no objections from my side, the proposed change is deliberately marked
as RFC, and I've decided to resend the patches just to show them publicly
and to gather more comments.

Best wishes,
Vladimir
