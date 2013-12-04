From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Dec 2013 10:01:36 +0000
Subject: [PATCHv6 05/13] iommu/core: add ops->{bound,unbind}_driver()
In-Reply-To: <20131204094027.dad1288aec14551ec42f3743@nvidia.com>
References: <1385041249-7705-1-git-send-email-hdoyu@nvidia.com>
 <1385041249-7705-6-git-send-email-hdoyu@nvidia.com>
 <20131125154937.d6dbe9aedc16aab335d92f99@nvidia.com>
 <20131204094027.dad1288aec14551ec42f3743@nvidia.com>
Message-ID: <20131204100136.GA10293@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Wed, Dec 04, 2013 at 07:40:27AM +0000, Hiroshi Doyu wrote:
> On Mon, 25 Nov 2013 14:49:37 +0100
> Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> 
> > Hi Joerg,
> > 
> > Do you have some time to review this patch along with the following ones?
> > 
> >   [PATCHv6 02/13] iommu/of: introduce a global iommu device list
> >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007050.html
> > 
> >   [PATCHv6 03/13] iommu/of: check if dependee iommu is ready or not
> >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007051.html
> 
> Any chance to get some feedback on them?

Joerg is on holiday at the moment, but Alex Williamson is serving as interim
IOMMU maintainer at the moment. Adding him to CC, but this probably needs an
Ack from Joerg regardless, so you will need to wait for him to come back.

Will
