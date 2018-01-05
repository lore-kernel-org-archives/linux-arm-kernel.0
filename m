From: pmladek@suse.com (Petr Mladek)
Date: Fri, 5 Jan 2018 12:38:42 +0100
Subject: [PATCH 00/13] replace print_symbol() with printk()-s
In-Reply-To: <20180105102105.GB471@jagdpanzerIV>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
 <20180105100300.j3svmcvvpfe2iows@pathway.suse.cz>
 <20180105102105.GB471@jagdpanzerIV>
Message-ID: <20180105113842.fczbwxuznyqqilom@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2018-01-05 19:21:05, Sergey Senozhatsky wrote:
> On (01/05/18 11:03), Petr Mladek wrote:
> [..]
> > Anyway, print_symbol() is an old weird API and it would be nice
> > to eventually get rid of it. I could take this patches into
> > printk.git.
> 
> no objections from my side if the patch set will go through the printk tree.
> shall we wait for ACKs or can we move on? do you plan to land it in 4.16?

I am going to add this into for-4.16 branch.

It is a rather cosmetic and trivial change. Therefore I do not think
that we would need to wait for all the ACKs. Anyway, I am going to
proactively check for potential conflicts with linux-next.

> > Would you mind if I change the commit messages to something like?:
> > 
> >     print_symbol() is an old weird API. It has been
> >     obsoleted by printk() and %pS format specifier.
> 
> I wouldn't. let's drop the "weird" part. other than that looks
> good to me.

OK.

Best Regards,
Petr
