From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 12:33:14 +0200
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
In-Reply-To: <20130626101028.GD27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com><20130626101028.GD27083@manwe>
Message-ID: <20130626.133314.1520719774895092173.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 12:10:30 +0200:

> * PGP Signed by an unknown key
> 
> On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> > Add "nvidia,memory-clients" to identify which swgroup ID a device
> > belongs to.
> 
> Why not call the property "nvidia,swgid" instead? That seems a lot more
> intuitive.

Tegra powerdomain also needs this info. Joseph?
