From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Mon, 20 Jan 2014 22:56:46 +0100
Subject: [PATCH v2 02/11] iommu/arm-smmu: Introduce iommu_group notifier
 block
In-Reply-To: <20140120215351.GG3471@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-3-git-send-email-andreas.herrmann@calxeda.com>
 <20140120215351.GG3471@alberich>
Message-ID: <20140120215646.GH3471@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:53:51PM +0100, Andreas Herrmann wrote:
> 
> At the moment just handle BUS_NOTIFY_BIND_DRIVER to conditionally
> isolate all master devices for an SMMU.

Oops, sent out too early. Please ignore this crap.
(An iommu_group notifier that is handling BUS_NOTIFY_BIND_DRIVER ...)


Andreas
