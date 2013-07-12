From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 12 Jul 2013 04:18:10 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712102326.GE24008@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com> <20130712080145.GC24008@pd.tnic>
 <20130712101319.GA13421@gmail.com> <20130712102326.GE24008@pd.tnic>
Message-ID: <20130712041810.53c86e5f.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Jul 2013 12:23:26 +0200 Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jul 12, 2013 at 12:13:19PM +0200, Ingo Molnar wrote:
> > and now it is upstream already, via -mm:
> > 
> >    e76e1fdfa8f8 lib: add support for LZ4-compressed kernel
> 
> Sure. Let's see if it manages to get released b0rked like it is right
> now.

Well y'know, if whining fixed bugs then there would be no problem here
at all.

This problem came up briefly and I thought it had been adequately
addressed.  Now a month or two later we find out who are the people who
can't be bothered testing -next, but think it terribly important that
others do so.
