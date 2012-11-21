From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:48:58 +0000
Subject: [PATCH 132/493] Input: remove use of __devexit_p
In-Reply-To: <1353349642-3677-132-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-132-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121114858.GE3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:21:21PM -0500, Bill Pemberton wrote:
>  drivers/input/serio/ambakmi.c               | 2 +-
>  drivers/input/serio/pcips2.c                | 2 +-
>  drivers/input/serio/rpckbd.c                | 2 +-
>  drivers/input/serio/sa1111ps2.c             | 2 +-

For these four,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
