From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 3 Jan 2012 23:28:44 +0100
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <20120102065956.GA13015@ponder.secretlab.ca>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <201112262013.19995.rjw@sisk.pl> <20120102065956.GA13015@ponder.secretlab.ca>
Message-ID: <201201032328.45288.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 02, 2012, Grant Likely wrote:
> On Mon, Dec 26, 2011 at 08:13:19PM +0100, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, December 12, 2011, Thomas Abraham wrote:
> > > A device node pointer is added to generic pm domain structure to associate
> > > the domain with a node in the device tree.
> > 
> > That sounds fine except for one thing: PM domains are not devices, so adding
> > "device node" pointers to them is kind of confusing.  Perhaps there should be
> > something like struct dt_node, representing a more general device tree node?
> 
> struct device_node has nothing to do with struct device.  device_node is a
> generic device tree node.

So the name is kind of confusing. :-)

> Thomas' approach is fine.

Well, I guess so.

Thanks,
Rafael
