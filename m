From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 9 Jan 2013 10:49:33 +0900
Subject: [PATCH 2/4] gpiolib: add gpiod_get and gpiod_put functions
In-Reply-To: <201301081307.04229.arnd@arndb.de>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <1357629535-26033-3-git-send-email-acourbot@nvidia.com>
 <201301081307.04229.arnd@arndb.de>
Message-ID: <CAAVeFu+1jYVTH7+cgRHb8LjQCJhSMZ9vR1=m+AH06bp+7Z4+fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 10:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 08 January 2013, Alexandre Courbot wrote:
>>
>> Adds new GPIO allocation functions that work with the opaque descriptor
>> interface.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> I think you need to reorder the patches slightly, since the gpiod_get
> function introduced here is already being used in the first patch, which
> breaks bisection.

Yes, gpiod_get and gpiod_put should only appear from the second patch
on. Thanks for pointing that out.

Alex.
