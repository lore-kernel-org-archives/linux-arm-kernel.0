From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 6 Dec 2016 16:58:18 +0100
Subject: [PATCH v2] ACPI/IORT: Make dma masks set-up IORT specific
In-Reply-To: <20161206142011.11859-1-lorenzo.pieralisi@arm.com>
References: <20161206142011.11859-1-lorenzo.pieralisi@arm.com>
Message-ID: <20161206155817.GA27203@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 02:20:11PM +0000, Lorenzo Pieralisi wrote:
>  drivers/acpi/arm64/iort.c | 22 ++++++++++++++++++++++
>  drivers/acpi/scan.c       | 14 +-------------
>  include/linux/acpi_iort.h |  2 ++
>  3 files changed, 25 insertions(+), 13 deletions(-)

Applied, thanks.
