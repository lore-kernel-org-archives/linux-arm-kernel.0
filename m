From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Jun 2013 17:41:40 +0100
Subject: [PATCH 7/9] documentation: iommu: add description of ARM System
 MMU binding
In-Reply-To: <20130621135507.GI11309@8bytes.org>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-8-git-send-email-will.deacon@arm.com>
 <20130620200845.GF11309@8bytes.org>
 <20130621095729.GA7766@mudshark.cambridge.arm.com>
 <20130621135507.GI11309@8bytes.org>
Message-ID: <20130621164139.GK7766@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 02:55:08PM +0100, Joerg Roedel wrote:
> On Fri, Jun 21, 2013 at 10:57:29AM +0100, Will Deacon wrote:
> > This is a common driver that will support any IOMMUs compatible with v1 or
> > v2 of the ARM SMMU architecture. Currently, that includes SMMUs known
> > informatively as MMU-400, MMU-401 and MMU-500. I had a look at the other
> > IOMMU drivers in the kernel and they seem to be driving incompatible IOMMUs,
> > so I don't see how this driver can replace those.
> > 
> > However, we'll hopefully see ARM SMMU-compatible devices turning up soon (I
> > know of many SoCs in development that are looking at them).
> 
> That sounds great. So in the future there will be a single driver for
> most future SOCs. This is a real improvement over the current situation.
> 
> From NVidia is another driver with 'smmu' in its name, is that one also
> incompatible?

Yup. I even checked with Stephen Warren before I started my driver, just in
case :)

Will
