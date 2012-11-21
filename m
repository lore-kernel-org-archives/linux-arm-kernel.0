From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:46:05 +0000
Subject: [PATCH 128/493] sound: remove use of __devexit_p
In-Reply-To: <1353349642-3677-128-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-128-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121114605.GD3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:21:17PM -0500, Bill Pemberton wrote:
>  sound/arm/aaci.c                    | 2 +-

For this driver,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
