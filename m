From: dt.tangr@gmail.com (Daniel Tang)
Date: Sat, 8 Jun 2013 11:42:54 +1000
Subject: [PATCH] Add Initial TI-Nspire support
In-Reply-To: <201306071955.26375.arnd@arndb.de>
References: <E775DD08-5516-468E-9924-0D839218D7F9@gmail.com>
 <D6B73C11-1EB8-472B-BA1E-E48CF205B43F@gmail.com>
 <201306071955.26375.arnd@arndb.de>
Message-ID: <9C5E608F-2DA8-469E-8C7C-B678B5EFC68B@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/06/2013, at 3:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 07 June 2013, Daniel Tang wrote:
>> Hi,
>> 
>> I was wondering if this patch had gone through yet.
> 
> Sorry, not yet.

A few things have changed since I sent in this patch so I need to add some adjustments to the patch. There's a few Kconfig options that need adding and some device tree bindings that need to be changed.

If it hasn't been merged yet, would it be possible for me to send version 2 of the patches? Or would you rather I wait until it is merged and send in a separate patch to fix them?

> Olof and I are usually taking turns with merging things
> into the arm-soc tree, but in the past few weeks he has done all of it,
> and he was not on Cc the patch. Please make sure you always send submissions
> for inclusion (as opposed to submissions for review purposes) to
> arm at kernel.org so it reaches both of us.

Ah my apologies. I will do that next time.

> 
> We are also sometimes missing requests for merging for patches (rather
> than git pull requests), so if you don't see your code show up in
> linux-next when it should, just send a friendly reminder like
> this one. I don't currently have a good overview of what pull
> requests are missing, so I think Olof should apply this one, or
> we can do a handover next week so I do the merging again for some
> time.
> 
> 	Arnd

Cheers,
Daniel Tang
