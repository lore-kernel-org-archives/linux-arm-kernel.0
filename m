From: joro@8bytes.org (joro at 8bytes.org)
Date: Fri, 6 Jul 2018 13:13:28 +0200
Subject: [PATCH 0/7 v5] Support for fsl-mc bus and its devices in SMMU
In-Reply-To: <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
 <HE1PR0401MB24250CEFBC0B7CC919C4388AE6760@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Message-ID: <20180706111327.7gkerhkk6udfeirr@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nipun,

On Thu, Jun 21, 2018 at 03:59:27AM +0000, Nipun Gupta wrote:
> Will this patch-set be taken for the next kernel release (and via which tree)?

I can take this through IOMMU tree if nobody objects. Please work out
the last remaining comment on patch 7 with Robin and then re-send with
all Acks and Reviewed-by: tags included.

Oh, and please use 'iommu/of:' prefix instead of 'iommu: of:' and follow
that sheme for the other patches/prefixes as well.

Thanks,

	Joerg
