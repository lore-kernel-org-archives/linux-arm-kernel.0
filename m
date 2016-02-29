From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 11:09:20 +0100
Subject: [PATCH] staging/goldfish: use 6-arg get_user_pages()
In-Reply-To: <20160226132812.a81d46c0151cb47f9433909f@linux-foundation.org>
References: <1456488033-4044939-1-git-send-email-arnd@arndb.de>
 <20160226132812.a81d46c0151cb47f9433909f@linux-foundation.org>
Message-ID: <4257177.cb22GWAUkR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 February 2016 13:28:12 Andrew Morton wrote:
> On Fri, 26 Feb 2016 12:59:43 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
> > The API change is currently only in the mm/pkeys branch of the
> > tip tree, while the goldfish_pipe driver started using the
> > old API in the staging/next branch.
> >
> > Andrew could pick it up into linux-mm in the meantime, or I can
> > resend it at some later point if nobody else does the change
> > after 4.6-rc1.
> 
> This is one for Ingo.
> 
...
> 
> This removes the first two arguments, which are now the default.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

As mentioned in my comment above, the patch can only get added
after the staging/next tree has also been merged, which I think
Ingo doesn't want to add to the tip tree.

	Arnd
