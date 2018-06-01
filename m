From: sakari.ailus@linux.intel.com (Sakari Ailus)
Date: Sat, 2 Jun 2018 01:35:07 +0300
Subject: [PATCH v3 2/8] dt-bindings: media: Document data-enable-active
 property
In-Reply-To: <20180601145827.GG10472@w540>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-3-git-send-email-jacopo+renesas@jmondi.org>
 <20180601102910.3qhe6bhg3w263chq@paasikivi.fi.intel.com>
 <20180601145827.GG10472@w540>
Message-ID: <20180601223506.n4cbfkm2cxbwixsi@kekkonen.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 04:58:27PM +0200, jacopo mondi wrote:
> Hi Sakari,
> 
> On Fri, Jun 01, 2018 at 01:29:10PM +0300, Sakari Ailus wrote:
> > Hi Jacopo,
> >
> > Thanks for the patch.
> >
> > On Tue, May 29, 2018 at 05:05:53PM +0200, Jacopo Mondi wrote:
> > > Add 'data-enable-active' property to endpoint node properties list.
> > >
> > > The property allows to specify the polarity of the data-enable signal, which
> > > when in active state determinates when data lanes have to sampled for valid
> > > pixel data.
> >
> > Lanes or lines? I understand this is forthe parallel interface.
> >
> 
> Now I'm confused. Are the parallel data 'lines' and the CSI-2 one
> 'lanes'? I thought 'lanes' applies to both.. am I wrong?

"Lane" is conventionally refer to a differential pair of wires on a serial
bus such as CSI-2. "Line" is used of a wire on a parallel bus.

-- 
Sakari Ailus
sakari.ailus at linux.intel.com
