From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 23 Jun 2014 18:14:43 -0400
Subject: [PATCH v3 1/7] genirq: generic chip: export
 irq_map_generic_chip function
In-Reply-To: <53A889C0.2090207@free-electrons.com>
References: <1403276487-8792-1-git-send-email-boris.brezillon@free-electrons.com>
 <1403276487-8792-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140621235108.GJ21711@titan.lakedaemon.net>
 <53A68CF0.8040303@free-electrons.com>
 <20140623130705.GM21711@titan.lakedaemon.net>
 <53A842C3.6060606@free-electrons.com>
 <20140623175041.GB10202@titan.lakedaemon.net>
 <53A889C0.2090207@free-electrons.com>
Message-ID: <20140623221443.GF10202@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 23/06/2014 19:50, Jason Cooper wrote:
...
> > I won't have a chance to dig deeper into this until tonight or the next
> > few days.  But my primary concern is that they chose to export the
> > struct for a reason.  I'd like to dig through the history and find out
> > why.

Ok, I took a look.  It seems that was the most expedient way to
implement the linear domain registration.  No mention of avoiding
exporting the functions directly. :)

thx,

Jason.
