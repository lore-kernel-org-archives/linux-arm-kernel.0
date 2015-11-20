From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 20 Nov 2015 11:39:31 -0500
Subject: [PATCH] [RESEND 2] SCSI: initio: remove duplicate module device
 table
In-Reply-To: <5318263.D61echQrl2@wuerfel> (Arnd Bergmann's message of "Thu, 19
 Nov 2015 15:33:41 +0100")
References: <5318263.D61echQrl2@wuerfel>
Message-ID: <yq1vb8wmxq4.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> The initio driver has for many years had two copies of the same
Arnd> module device table. One of them is also used for registering the
Arnd> other driver, the other one is entirely useless after the large
Arnd> scale cleanup that Alan Cox did back in 2007.

Applied.

-- 
Martin K. Petersen	Oracle Linux Engineering
