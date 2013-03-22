From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 14:16:42 +0000
Subject: [PATCH 0/9] More ux500 multiplatform stuff
In-Reply-To: <CACRpkdYUZQt+PTOf0+ReQFWgSjitXM-CXMUfVAiQsL3QxDTi5w@mail.gmail.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <201303221334.07330.arnd@arndb.de>
 <CACRpkdYUZQt+PTOf0+ReQFWgSjitXM-CXMUfVAiQsL3QxDTi5w@mail.gmail.com>
Message-ID: <201303221416.42217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Linus Walleij wrote:
> On Fri, Mar 22, 2013 at 2:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > [Me]
> >> And there are some non-bisectable patches due to the
> >> driver in staging (which was put there because Synaptics would
> >> submit another driver "real soon now" and that was something like
> >> two years ago), so I might have to squash some of them together to one.
> >
> > What breaks bisection here? The "[PATCH 5/9] staging: ste_rmi4: kill
> > platform_data hack" patch should be independent of everything else,
> > it just touches more files than we'd like.
> 
> It includes <mach/irqs.h> that is removed by earlier patches, so
> it stops compiling before this patch.
> 

Ah right. I think I reordered the patches in the end and must have gotten
that one wrong.

	Arnd
