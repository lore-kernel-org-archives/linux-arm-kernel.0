From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 22 Oct 2009 21:19:55 +0200
Subject: zaurus: cleanup sharpsl_pm.c
In-Reply-To: <f17812d70910221126k50c4ea7em9d58f6e85db884ae@mail.gmail.com>
References: <20091006200339.GA1538@ucw.cz> <20091017163627.GB1423@ucw.cz>
	<f17812d70910200859v6d18e81bs2760d8af1d8da5bf@mail.gmail.com>
	<f17812d70910220705o9f4a0ddwa22157b59a519350@mail.gmail.com>
	<20091022174816.GC5325@elf.ucw.cz>
	<f17812d70910221126k50c4ea7em9d58f6e85db884ae@mail.gmail.com>
Message-ID: <20091022191954.GB6611@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2009-10-23 02:26:55, Eric Miao wrote:
> > Introduce separate set of battery limits for corgi. This fixes
> > compilation, and the values probably should be subtly different, too.
> 
> [Why I'm receiving this for twice ....?]

No idea. Perhaps once from maillist?

> Pavel,
> 
> Anyway, I was thinkin maybe we need a shared table before there
> are real requirements for different machines to have their own?

Well, I'd say that the sharing leads to some very ugly code. ... so
I'd preer it unshared.

But if you would prefer, I can prepare patch without the table
moving...?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
