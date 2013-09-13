From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 12 Sep 2013 23:30:10 -0400
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130912102027.GF29403@sirena.org.uk>
References: <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
 <20130911104126.GN29403@sirena.org.uk>
 <52304BFF.4060007@freescale.com>
 <20130911113002.GP29403@sirena.org.uk>
 <523186DF.4070203@freescale.com>
 <20130912102027.GF29403@sirena.org.uk>
Message-ID: <20130913033008.GC3051@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 11:20:27AM +0100, Mark Brown wrote:
> On Thu, Sep 12, 2013 at 05:18:23PM +0800, Huang Shijie wrote:
> 
> > yes. The driver uses the commands to find the _right_ LUT index, and
> > uses the LUT index to
> > trigger the controller.
> 
> What is a LUT index?
we can setup 16 valid instruction sequences at most,
for example:
     LUT0 - LUT3: for read status of NOR
     LUT4 - LUT7: for write enable of NOR
     ...........

The LUT index is 0 for read-status;
the LUT index is 1 for write-enable.

thanks
Huang Shijie
