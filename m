From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 14 Sep 2013 09:49:27 +0200
Subject: [PATCH 1/2] Documentation: devicetree: arm: cpus/cpu nodes
 bindings updates
In-Reply-To: <52337AEC.9080302@gmail.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-2-git-send-email-lorenzo.pieralisi@arm.com>
 <520CE665.8060907@gmail.com>
 <20130815152238.GF17839@e102568-lin.cambridge.arm.com>
 <20130913165708.GC5408@e102568-lin.cambridge.arm.com>
 <52337AEC.9080302@gmail.com>
Message-ID: <20130914074927.GA23705@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 03:51:56PM -0500, Rob Herring wrote:
> On 09/13/2013 11:57 AM, Lorenzo Pieralisi wrote:
> > Hi Rob, all,
> > 
> > On Thu, Aug 15, 2013 at 04:22:38PM +0100, Lorenzo Pieralisi wrote:
> >> [adding Andrew, Gregory and Thomas to check the Marvell compatible names]
> >>
> >> On Thu, Aug 15, 2013 at 03:32:05PM +0100, Rob Herring wrote:
> >>> On 08/15/2013 04:42 AM, Lorenzo Pieralisi wrote:
> >>>> In order to extend the current cpu nodes bindings to newer CPUs
> >>>> inclusive of AArch64 and to update support for older ARM CPUs this
> >>>> patch updates device tree documentation for the cpu nodes bindings.
> >>>>
> >>>> Main changes:
> >>>>     - adds 64-bit bindings
> >>>>     - define usage of #address-cells
> >>>>     - defines behaviour on pre and post v7 uniprocessor systems
> >>>>     - adds ARM 11MPcore specific reg property definition
> >>>>
> >>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/arm/cpus.txt | 424 ++++++++++++++++++++++---
> >>>>  1 file changed, 377 insertions(+), 47 deletions(-)
> >>>>
> >>>
> >>> The binding looks mostly fine to me.
> > 
> > These bindings have still not received an ACK, and need review by
> > Marvell guys in copy for the new compatible strings below.
> 
> If you can't get comment, then leave them out if they are not used
> already. If they are used, then tough shit when they want to change.

Hi Rob

We are working on it. Hope to be able to comment soon.

   Andrew
