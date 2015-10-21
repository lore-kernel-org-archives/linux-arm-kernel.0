From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 11:04:06 +0200
Subject: [GIT PULL] at91: dt for 4.4 #2
In-Reply-To: <20151021085009.GM3421@piout.net>
References: <20151019193158.GA20739@piout.net>
 <20151021085009.GM3421@piout.net>
Message-ID: <6875021.MsurUX5CVC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 10:50:09 Alexandre Belloni wrote:
> Hi,
> 
> Actually, this built on my machine because one of the headers was left
> unversionned in my tree. The last patch depends on the MFD tree, I'm not
> sure how you want to handle that. I can as well drop the last patch and
> resend a PR.
> 

Yes, that would be better.

In general, when you have dependencies like this, they should be discussed
with all maintainers in advance so we can come up with a plan.

Often that means having two branches that both start with the same patch
that contains the dependency, but it's probably too late for that now,
as the other patch has already been merged to the MFD tree.

If that last patch has no dependencies or conflicts with the rest of the
changes, you can also get an Ack from us to merge it through the MFD
tree, but we normally try to avoid that.

	Arnd
