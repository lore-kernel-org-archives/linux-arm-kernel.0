From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 18 May 2015 10:34:33 +0200
Subject: [PATCH v2 1/5] kasan, x86: move KASAN_SHADOW_OFFSET to the arch
 Kconfig
In-Reply-To: <55599821.40409@samsung.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-2-git-send-email-a.ryabinin@samsung.com>
 <1431775656.2341.10.camel@x220> <55599821.40409@samsung.com>
Message-ID: <1431938073.2204.3.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-05-18 at 10:43 +0300, Andrey Ryabinin wrote:
> On 05/16/2015 02:27 PM, Paul Bolle wrote:
> > So perhaps the
> > default line should actually read
> > 	default 0xdffffc0000000000 if KASAN
> > 
> > after the move. Would that work?
> 
> Yes, but I would rather add "depends on KASAN".

That would have the same effect, as far as I can see, so if adding
"depends on KASAN" works for you that's fine with me too.

Thanks,


Paul Bolle
