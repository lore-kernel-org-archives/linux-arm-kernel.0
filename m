From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 10 Feb 2016 20:24:21 -0500
Subject: [PATCH 0/7] SCSI bug fixes for 4.6
In-Reply-To: <1453910247-3447628-1-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 27 Jan 2016 16:57:16 +0100")
References: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
Message-ID: <yq1si1082ey.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> Here are a bunch of fixes for harmless bugs I found during ARM
Arnd> randconfig testing. It would be nice to get them mered in 4.6, but
Arnd> there is no need to have them in 4.5 as no incorrect behavior
Arnd> results from the current code, and the warnings are all hard to
Arnd> trigger.

Applied to 4.6/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
