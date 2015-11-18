From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 18 Nov 2015 10:18:30 -0500
Subject: [PATCH, resend] scsi: advansys: fix big-endian builds
In-Reply-To: <4411376.blKgWIg75B@wuerfel> (Arnd Bergmann's message of "Mon, 16
 Nov 2015 17:49:23 +0100")
References: <4411376.blKgWIg75B@wuerfel>
Message-ID: <yq1mvubs5dl.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> Building the advansys driver in a big-endian configuration such as
Arnd> ARM allmodconfig shows a warning:

Applied to 4.4.

-- 
Martin K. Petersen	Oracle Linux Engineering
