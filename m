From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 12:00:40 +0000
Subject: [PATCH 298/493] video: remove use of __devinitdata
In-Reply-To: <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121120040.GJ3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:24:07PM -0500, Bill Pemberton wrote:
>  drivers/video/acornfb.c                |  8 +++---
>  drivers/video/cyber2000fb.c            |  2 +-
>  drivers/video/sa1100fb.c               |  2 +-

For these three,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
