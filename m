From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Oct 2016 17:57:21 +0100
Subject: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <alpine.DEB.2.20.1610211641430.27636@digraph.polyomino.org.uk>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <3851270.xZRcP9hae0@wuerfel>
 <20161021133708.GA1041@n2100.armlinux.org.uk>
 <4337157.Eff9E2riVH@wuerfel>
 <20161021154856.GC1041@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1610211641430.27636@digraph.polyomino.org.uk>
Message-ID: <20161021165721.GD1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 04:48:36PM +0000, Joseph Myers wrote:
> On Fri, 21 Oct 2016, Russell King - ARM Linux wrote:
> 
> > To stop adding OABI syscalls altogether.  I'm sure that there will
> > come a point (if it hasn't already) that glibc no longer supports
> > OABI, and at that point it probably becomes rather silly to keep
> > adding OABI syscalls.
> 
> glibc hasn't supported OABI since 2012 (support removed in version 2.16 
> released 2012-06-30).  GCC support was also removed in 2012 (removal 
> released in version 4.8, released 2013-03-22).

Right, so arguably its pointless adding new syscalls to OABI anymore.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
