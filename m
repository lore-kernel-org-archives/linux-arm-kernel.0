From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 04 Sep 2015 23:20:29 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <yw1x4mjaxhqy.fsf@unicorn.mansr.com>
References: <55E5CED8.7000408@free.fr> <55E9C33A.2080801@free.fr>
 <yw1x4mjaxhqy.fsf@unicorn.mansr.com>
Message-ID: <1618882.v0koDYGhyB@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 04, 2015 05:37:57 PM M?ns Rullg?rd wrote:
> Mason <slash.tmp@free.fr> writes:
> > On 02/09/2015 20:01, Mason wrote:
> >> On 02/09/2015 19:17, M?ns Rullg?rd wrote:
> >>> Use the latest DT from my tree.  It looks like you're missing some
> >>> changes.
> >> 
> >> Indeed, my repo is not up-to-date. (I was vaguely worried that you'd
> >> have made further changes that I'd have to revert when back-porting
> >> to 3.14)
> >> 
> >> I'll try upgrading and report back.
> >> 
> >> By the way, did you write the DT from scratch?
> >> 
> >> Are there people walking this earth that can write device tree like C?
> > 
> > No cigar :-(
> > 
> > There's just too much DT syntax that flies light-years over my head.
> > #address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
> > Basically, all I understand is /dts-v1/;
> > (Anyone have links to good tutorials?)
> 
> Here's something: http://devicetree.org/Device_Tree_Usage

And here:
http://events.linuxfoundation.org/sites/events/files/slides/petazzoni-device-tree-dummies.pdf

Video to the slides:
https://www.youtube.com/watch?v=m_NyYEBxfn8

Have fun ;)

Matthias
