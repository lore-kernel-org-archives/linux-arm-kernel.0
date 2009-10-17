From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 17 Oct 2009 12:42:39 +0800
Subject: [PATCH] Re: spitz: add gpio button support (fixes regression)
In-Reply-To: <1255731737.12593.4.camel@utx.utx.cz>
References: <20091007120643.GA17069@rakim.wolfsonmicro.main>
	<1255641385.3985.55.camel@utx.utx.cz>
	<20091015212024.GC15898@elf.ucw.cz>
	<1255643252.3985.63.camel@utx.utx.cz>
	<20091015215215.GG15898@elf.ucw.cz>
	<1255685315.5470.3.camel@hammer.suse.cz>
	<20091016093950.GI15898@elf.ucw.cz>
	<1255719006.9583.31.camel@utx.utx.cz>
	<20091016190521.GB17849@n2100.arm.linux.org.uk>
	<1255731737.12593.4.camel@utx.utx.cz>
Message-ID: <f17812d70910162142r72d58f08gffafedb4cd008655@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2009 at 6:22 AM, Stanislav Brabec <utx@penguin.cz> wrote:
> Russell King - ARM Linux wrote:
>> I'm not sure we want to apply this patch - it has UTF <U+FEFF>
>> sequences embedded randomly in it.

That's ZWNBSP - Zero-Width No-Break Space (unicode character FEFF).
I think Stanislav needs to train his evolution a little bit for this.

Anyway, applied to 'fix' with the above special character removed.
