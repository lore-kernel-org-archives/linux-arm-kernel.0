From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:08:36 +0200
Subject: [PATCH v2 00/22] Unified SMMU driver among Tegra SoCs
In-Reply-To: <4999563.JlU6BysXQl@fb07-iapwap2.physik.uni-giessen.de>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><4999563.JlU6BysXQl@fb07-iapwap2.physik.uni-giessen.de>
Message-ID: <20130705.140836.1744157186948281659.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Marc Dietrich <marvin24@gmx.de> wrote @ Fri, 5 Jul 2013 13:03:58 +0200:

> Am Freitag, 5. Juli 2013, 13:44:35 schrieb Hiroshi Doyu:
> > Hi,
> > 
> > This series provides:
> > 
> > (1) Unified SMMU driver among Tegra SoCs
> 
> does this affect tegra2 in any way?

No, at all for Tegra 20.
This driver should work with Tegra 30, 114 and 148.
