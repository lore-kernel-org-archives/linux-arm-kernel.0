From: w@1wt.eu (Willy Tarreau)
Date: Sun, 9 Dec 2012 23:37:53 +0100
Subject: [PATCH v2] ARM: kirkwood: convert Guruplug Server Plus to use the
 device tree
In-Reply-To: <20121209220245.GF21694@titan.lakedaemon.net>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net> <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net> <20121209184004.GC28052@1wt.eu>
 <20121209220245.GF21694@titan.lakedaemon.net>
Message-ID: <20121209223753.GE28052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 09, 2012 at 05:02:45PM -0500, Jason Cooper wrote:
> > +	model = "Globalscale Technologies Guruplug Server Plus";
> > +	compatible = "globalscale,guruplug-server-plug", "globalscale,guruplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> One small typo, should be "...server-plus".  If there are no other
> comments over the next few days, I'll tweak it when I pull it in.

I'm amazed, because you did exactly the same one in your initial review
last week and I noticed it back then. Then I did this one without copy-
pasting yours! It seems like our brain is too much attracted by those
similarly looking letters. Sorry for this one.

Thanks,
Willy
