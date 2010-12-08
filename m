From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 08 Dec 2010 12:57:55 -0800
Subject: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
	files
In-Reply-To: <alpine.DEB.2.00.1012072338130.13430@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 7 Dec 2010 23:40:03 -0700 (MST)")
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012514.3708.87532.stgit@twilight.localdomain>
	<4CFE9C7C.6060101@ti.com>
	<alpine.DEB.2.00.1012072338130.13430@utopia.booyaka.com>
Message-ID: <8739q8gey4.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Tue, 7 Dec 2010, Cousson, Benoit wrote:
>
>> On 12/7/2010 2:25 AM, Paul Walmsley wrote:
>> 
>> [...]
>> 
>> > + *
>> > + * XXX This file needs to be updated to align on one of "OMAP4",
>> > "OMAP44XX",
>> > + *     or "OMAP4430".
>> 
>> Yep, I was thinking to change that as well. My first thought was OMAP4 to get
>> a shorter name, but when we will introduce OMAP4440, we might have some new
>> entries, that will looks ugly close to OMAP4.
>> So at the end I will prefer OMAP44XX for the moment and we might renamed to
>> OMAP4430 or OMAP4440 for the entries that will diverge.
>> 
>> Do you want to change that for 2.6.38?
>> It will require some sync with the various users of these defines, but that
>> should be doable.
>
> I don't mind waiting until after 2.6.38, I think we'll have a pretty huge 
> pile of patches on our hands to merge already for .38... maybe Tony or 
> Kevin have some opinions though.

I think this should wait 'til after 2.6.38, but be early in the next
cycle so all dependencies can be handled early.

Kevin
