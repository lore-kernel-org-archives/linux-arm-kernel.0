From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Sat, 13 Mar 2010 16:50:53 +0100
Subject: Git pull request: ARM LPC32XX architecture
In-Reply-To: <20100312210353.GB1146@n2100.arm.linux.org.uk>
References: <a08234131003121244t6f914926s3ea75e98c017686a@mail.gmail.com>
	<20100312210353.GB1146@n2100.arm.linux.org.uk>
Message-ID: <20100313155053.GU8885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Mar 12, 2010 at 09:03:53PM +0000, Russell King - ARM Linux wrote:
> However, what I do want to avoid this time around is having an
> excessive number of merge conflicts, which may require a pause to
> sort out (and I might ask people to bring their trees up to date
> first.)

Hmm, maybe we should make sure that more of the arm-sub-trees are in
linux-next; would that make the situation easier? If all of the trees
you pull are in next, at least in theory it should be a matter of
pulling them in the right order and send a pull request to linus.

At least in theory :)

Since Sascha has the i.MX tree in next and we're automatically testing
next (compiletime+runtime on several boards) on a nightly base, we've
found that merge conflicts are noticed in a timely manner.

Thanks,
rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
