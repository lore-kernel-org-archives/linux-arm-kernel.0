From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue, 15 Feb 2011 15:09:04 +0200 (EET)
Subject: [PATCH v2] OMAP: IOMMU: add missing function declaration
In-Reply-To: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
References: <1297769473-24052-1-git-send-email-dacohen@gmail.com>
Message-ID: <20110215.150904.31489671848521371.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v2] OMAP: IOMMU: add missing function declaration
Date: Tue, 15 Feb 2011 13:31:13 +0200

> Declaration of exported function 'iopgtable_lookup_entry' is missing from
> header file. Currently we have a sparse warning as it's not being used
> externally. Adding its declaration to avoid such warning and allow its usage
> in future.
> 
> Signed-off-by: David Cohen <dacohen@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/iommu.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

Thanks. Tony, Please put this into your queue.
