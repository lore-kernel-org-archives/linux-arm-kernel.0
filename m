From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 10 Jan 2013 15:49:31 -0500
Subject: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
In-Reply-To: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Message-ID: <20130110204931.GP5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 09:29:15PM +0100, Andrew Lunn wrote:
> A NULL is a valid clk cookie, so we should not be tested with
> IS_ERR_NULL(). Replace it with IS_ERR().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The subject and commit entry should be IS_ERR_OR_NULL, but other than
that:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
