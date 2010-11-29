From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 29 Nov 2010 11:57:58 +0200
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <1290821087.2529.252.camel@helium>
References: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
	<536589.12568.qm@web180310.mail.gq1.yahoo.com>
	<AANLkTinQdNC0XaOqNyDbdYE6ZcP0QyzpN492j=Kovuea@mail.gmail.com>
	<1290716548.2529.136.camel@helium>
	<AANLkTi=sZ-4BBLAJNU5B41cAxtroGkpNomgEYO4vtx8z@mail.gmail.com>
	<1290821087.2529.252.camel@helium>
Message-ID: <AANLkTimxP0ejc5i8cbEmdFidvCgH1pk5-Vc_WEGM2Hwa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 27, 2010 at 3:24 AM, David Brownell <david-b@pacbell.net> wrote:
> Your intent "generic" is fine, but you've not achieved it and thus I
> think you shouldn't imply that you have. ? Dropping the word "generic"
> should ?suffice; it _is_ a framework, and maybe the next person working
> with hardware spinlocks can finish generalizing (and add use cases).

Sure, I can drop the word "generic".

> Haven't looked at RT in a long time. ?Just look at the current RT
> patchset to see if it still has several spinlock variants. ?ISTR the
> "raw" spinlock stuff came from there not long ago. ?Much compile-time
> magic was involved in switching between variants.

I'll take a look there and see if I catch anything relevant.

Thanks,
Ohad.


>
> - Dave
>
>
>
