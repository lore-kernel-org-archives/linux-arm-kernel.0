From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 25 Nov 2015 22:28:34 -0500
Subject: [PATCH] scsi: use sector_div instead of do_div
In-Reply-To: <24882658.08y4bWL6tn@wuerfel> (Arnd Bergmann's message of "Fri,
 20 Nov 2015 17:38:28 +0100")
References: <24882658.08y4bWL6tn@wuerfel>
Message-ID: <yq1bnahjv6l.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> do_div is the wrong way to divide a sector_t, as it is less
Arnd> efficient when sector_t is 32-bit wide. With the upcoming do_div
Arnd> optimizations, the kernel starts warning about this:

Applied.

-- 
Martin K. Petersen	Oracle Linux Engineering
