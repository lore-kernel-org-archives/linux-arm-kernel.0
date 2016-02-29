From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Feb 2016 13:32:25 -0800
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
In-Reply-To: <17470332.nnZZr9fh67@wuerfel>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
 <56D40505.8020702@ti.com> <20160229181606.GM13417@atomide.com>
 <17470332.nnZZr9fh67@wuerfel>
Message-ID: <20160229213225.GN13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [160229 12:46]:
> On Monday 29 February 2016 10:16:07 Tony Lindgren wrote:
> > Yes I understand that if we need to set it at the top level. But what
> > happens if you only set it for the memory node?
> > 
> > With just something like:
> > 
> > memory {
> >        #address-cells = <2>;
> >        #size-cells = <2>;
> >        ...
> > };
> 
> Nothing happens there: the memory node has no children, and no
> ranges property, so the two properties are never referenced.

OK thanks.

Tony
