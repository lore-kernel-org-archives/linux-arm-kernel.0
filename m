From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 22 Oct 2009 09:05:27 +0200
Subject: spitz backlight: fix brightness limiting
In-Reply-To: <f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
References: <20091019213751.GC1482@ucw.cz>
	<f17812d70910211320s29d3aaa5tad3206df1e99e03b@mail.gmail.com>
Message-ID: <20091022070527.GE2211@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2009-10-22 04:20:34, Eric Miao wrote:
> It's a little bit weird it's called 'limit_mask' when I first converted it
> to a spi driver. There must be some reasons, Richard, you've got
> any ideas?

Yes, the code was "interesting"...

I can certainly do the rename, but maybe we can fix the issue now and
do futher cleanups later?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
