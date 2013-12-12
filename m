From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 16:15:30 -0500
Subject: [PATCH] dma: mv_xor: fix kernel crash on probe error
In-Reply-To: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
References: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20131212211530.GB2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:11:55PM +0200, Aaro Koskinen wrote:
> If the non-DT channel add path fails, the kernel will crash as the
> channel is not set to NULL and it will try to release the channel using
> the error value. Fix that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/dma/mv_xor.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
