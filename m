From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 Aug 2017 21:32:52 +0200
Subject: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
In-Reply-To: <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
 <20170724162918.21050-5-mperttunen@nvidia.com>
 <1502420276.2598.5.camel@intel.com>
 <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
Message-ID: <20170830193252.GA12761@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 10:40:44AM +0800, Wei Ni wrote:
> 
> 
> On Friday, August 11, 2017 10:57 AM, Zhang Rui wrote:
> > On Mon, 2017-07-24 at 19:29 +0300, Mikko Perttunen wrote:
> >> On Tegra186, the BPMP (Boot and Power Management Processor) exposes
> >> an
> >> interface to thermal sensors on the system-on-chip. This driver
> >> implements access to the interface. It supports reading the
> >> temperature, setting trip points and receiving notification of a
> >> tripped trip point.
> >>
> >> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > 
> > Wei Ni,
> > 
> > what do you think of this patch?
> 
> Reviewed this patch, it looked fine to me.

Can I take this as a Reviewed-by?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170830/cc7fc6fb/attachment.sig>
