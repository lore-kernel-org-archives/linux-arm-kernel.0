From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 12 Jul 2013 12:13:19 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712080145.GC24008@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com> <20130712080145.GC24008@pd.tnic>
Message-ID: <20130712101319.GA13421@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Jul 12, 2013 at 09:56:02AM +0200, Ingo Molnar wrote:
> >
> > If a utility is not widely available yet and if the utility is not in 
> > the kernel proper, could you please at least make sure that randconfig 
> > does not stumble over non-buildable kernels?
> 
> Two months ago I've complained about this and other people have burned 
> themselves too in the meantime...

and now it is upstream already, via -mm:

   e76e1fdfa8f8 lib: add support for LZ4-compressed kernel


Thanks,

	Ingo
