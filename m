From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Aug 2017 14:45:06 +0200
Subject: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
In-Reply-To: <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
 <20170724162918.21050-5-mperttunen@nvidia.com>
 <1502420276.2598.5.camel@intel.com>
 <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
Message-ID: <20170831124506.GA16437@ulmo.fritz.box>
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

Hi Zhang,

given the build-time dependencies, how about if I take this into the
Tegra tree with an Acked-by from you? I can provide a stable branch with
the dependencies included if you want to pull it into your tree in order
to resolve dependencies.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/16408449/attachment.sig>
