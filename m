From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 19 Dec 2012 16:37:47 +0000
Subject: [PATCH 1/4 v2] spi: sh-msiof: Remove unneeded clock name
In-Reply-To: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
References: <1355313289-29769-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <20121219163747.A98E93E0C08@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Dec 2012 12:54:46 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
> From: Bastian Hecht <hechtb@gmail.com>
> 
> clk_get() no longer needs a character string for associating the right
> clock as this is done via the device struct now.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

This change is already in mainline.

g.
