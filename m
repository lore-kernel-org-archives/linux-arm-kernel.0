From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 20 Nov 2015 11:42:36 -0500
Subject: [PATCH] scsi: hpsa: select CONFIG_SCSI_SAS_ATTR
In-Reply-To: <3970646.5sOyETUiWo@wuerfel> (Arnd Bergmann's message of "Thu, 19
 Nov 2015 23:04:35 +0100")
References: <3970646.5sOyETUiWo@wuerfel>
Message-ID: <yq1r3jkmxkz.fsf@sermon.lab.mkp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Arnd" == Arnd Bergmann <arnd@arndb.de> writes:

Arnd> The hpsa driver recently started using the sas transport class,
Arnd> but it does not ensure that the corresponding code is actually
Arnd> built, which may lead to a link error:

Applied.

-- 
Martin K. Petersen	Oracle Linux Engineering
