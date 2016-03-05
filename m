From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Sat, 05 Mar 2016 17:08:49 -0500
Subject: [PATCH 08/14] scsi: mvumi: use __maybe_unused to hide pm functions
In-Reply-To: <1456934350-1389172-9-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 2 Mar 2016 16:59:00 +0100")
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-9-git-send-email-arnd@arndb.de>
Message-ID: <yq17fhg4lxq.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> The mvumi scsi hides the references to its suspend/resume
Arnd> functions in an #ifdef but does not hide the implementation the
Arnd> same way:

Applied to 4.6/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
