From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Nov 2012 11:55:44 +0000
Subject: [PATCH 198/493] ethernet: remove use of __devinit
In-Reply-To: <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-198-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121121115544.GG3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:22:27PM -0500, Bill Pemberton wrote:
>  drivers/net/ethernet/8390/etherh.c                 |  4 +-
>  drivers/net/ethernet/amd/am79c961a.c               |  2 +-
>  drivers/net/ethernet/i825xx/ether1.c               |  8 +-
>  drivers/net/ethernet/seeq/ether3.c                 | 10 +--

For these four,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
