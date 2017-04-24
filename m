From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 24 Apr 2017 18:32:41 -0400
Subject: [PATCH V2] scsi: mpt3sas: remove redundant wmb
In-Reply-To: <1491591978-17880-1-git-send-email-okaya@codeaurora.org> (Sinan
 Kaya's message of "Fri, 7 Apr 2017 15:06:18 -0400")
References: <1491591978-17880-1-git-send-email-okaya@codeaurora.org>
Message-ID: <yq1d1c1h1x2.fsf@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sinan,

> Due to relaxed ordering requirements on multiple architectures,
> drivers are required to use wmb/rmb/mb combinations when they need to
> guarantee observability between the memory and the HW.

Applied to 4.12/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
