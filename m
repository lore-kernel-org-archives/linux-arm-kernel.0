From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:45:21 +0000
Subject: [PATCH 097/493] scsi: remove use of __devexit_p
In-Reply-To: <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121114521.GC3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:20:46PM -0500, Bill Pemberton wrote:
>  drivers/scsi/arm/acornscsi.c              | 2 +-
>  drivers/scsi/arm/arxescsi.c               | 2 +-
>  drivers/scsi/arm/cumana_1.c               | 2 +-
>  drivers/scsi/arm/cumana_2.c               | 2 +-
>  drivers/scsi/arm/eesox.c                  | 2 +-
>  drivers/scsi/arm/oak.c                    | 2 +-
>  drivers/scsi/arm/powertec.c               | 2 +-

For these drivers,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
