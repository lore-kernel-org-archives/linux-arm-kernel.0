From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 20 Nov 2015 11:38:30 -0500
Subject: [PATCH v3] scsi: advansys needs ISA dma api for ISA support
In-Reply-To: <4355540.BF55dNX7U7@wuerfel> (Arnd Bergmann's message of "Thu, 19
 Nov 2015 15:22:23 +0100")
References: <4355540.BF55dNX7U7@wuerfel>
Message-ID: <yq1ziy8mxrt.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> The advansys drvier uses the request_dma function that is used on
Arnd> ISA machines for the internal DMA controller, which causes build
Arnd> errors on platforms that have ISA slots but do not provide the ISA
Arnd> DMA API:

Applied.

-- 
Martin K. Petersen	Oracle Linux Engineering
