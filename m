From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Mar 2018 16:08:14 +0100
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
Message-ID: <20180305150814.GA15918@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should not add any new hardocded busses here.  Please mark them in
OF/ACPI.
