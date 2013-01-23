From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 Jan 2013 20:09:31 -0500
Subject: [PATCH 1/5] mmc: mvsdio: use devm_ API to simplify/correct
 error paths.
In-Reply-To: <1358342040-7130-2-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
 <1358342040-7130-2-git-send-email-andrew@lunn.ch>
Message-ID: <20130123010931.GB1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 02:13:56PM +0100, Andrew Lunn wrote:
> There are a number of bugs in the error paths of this driver.  Make
> use of devm_ functions to simplify the cleanup on error.
> 
> Based on a patch by Russell King.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |   92 +++++++++++++++------------------------------
>  1 file changed, 30 insertions(+), 62 deletions(-)

Applied to mvebu/fixes

thx,

Jason.
