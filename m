From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 2 Jun 2011 17:12:58 +0900
Subject: [PATCH 8/10] drivers/video/imxfb.c: add missing clk_put
In-Reply-To: <1306948213-20767-10-git-send-email-julia@diku.dk>
	<1306948213-20767-8-git-send-email-julia@diku.dk>
References: <1306948213-20767-10-git-send-email-julia@diku.dk>
	<1306948213-20767-8-git-send-email-julia@diku.dk>
Message-ID: <20110602081258.GE6087@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 07:10:11PM +0200, Julia Lawall wrote:
>  drivers/video/imxfb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

On Wed, Jun 01, 2011 at 07:10:13PM +0200, Julia Lawall wrote:
>  drivers/video/pxa168fb.c |   17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
Both applied, thanks.
