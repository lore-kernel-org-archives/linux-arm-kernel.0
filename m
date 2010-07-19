From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Tue, 20 Jul 2010 00:26:13 +0300
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<20100719194940.GA14766@shutemov.name>
	<AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
Message-ID: <20100719212613.GA15071@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 10:02:12PM +0200, Linus Walleij wrote:
> 2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:
> 
> > Why do we need this? Why do not just fix broken programs?
> 
> People tend to use some third-party precompiled binaries, some of
> them compiled with a compiler using SWP.
> 
> A typical example is the CDC Java runtime, JRE.

I think beter to describe it in commit message.

-- 
 Kirill A. Shutemov
