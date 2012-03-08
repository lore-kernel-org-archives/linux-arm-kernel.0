From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 8 Mar 2012 16:45:03 +0100
Subject: [PATCH 05/11] tps6586x: Add device-tree support
In-Reply-To: <20120308151756.GQ3638@opensource.wolfsonmicro.com>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-6-git-send-email-thierry.reding@avionic-design.de>
 <20120308150607.GP3638@opensource.wolfsonmicro.com>
 <20120308151545.GA23934@avionic-0098.mockup.avionic-design.de>
 <20120308151756.GQ3638@opensource.wolfsonmicro.com>
Message-ID: <20120308154502.GA4617@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Thu, Mar 08, 2012 at 04:15:46PM +0100, Thierry Reding wrote:
> > * Mark Brown wrote:
> 
> > > ...they all seem to be explicitly named in the device tree so presumably
> > > there's enough information in there for the driver to pick any set of
> > > regulators in any order.  This would be much nicer to use.
> 
> > I don't like it much either. The only reason that requirement exists is
> > because it makes the assignment of the regulator ID (as defined in the
> > include/linux/mfd/tps6586x.h header) very trivial. Would it be better to
> > look up the ID based on the node name (sm0 --> TPS6586X_ID_SM_0, ...)?
> 
> > Then the only requirement would be that the names match.
> 
> Yes, that's going to be more code but much nicer for users.

Okay, I'll add that for the next round.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/6cfa72be/attachment.sig>
