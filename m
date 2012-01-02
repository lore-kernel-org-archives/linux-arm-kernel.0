From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 1 Jan 2012 23:59:56 -0700
Subject: [PATCH 1/2] PM / Domains: Add OF support
In-Reply-To: <201112262013.19995.rjw@sisk.pl>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <201112262013.19995.rjw@sisk.pl>
Message-ID: <20120102065956.GA13015@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2011 at 08:13:19PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, December 12, 2011, Thomas Abraham wrote:
> > A device node pointer is added to generic pm domain structure to associate
> > the domain with a node in the device tree.
> 
> That sounds fine except for one thing: PM domains are not devices, so adding
> "device node" pointers to them is kind of confusing.  Perhaps there should be
> something like struct dt_node, representing a more general device tree node?

struct device_node has nothing to do with struct device.  device_node is a
generic device tree node.  Thomas' approach is fine.

g.
