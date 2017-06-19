From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 19 Jun 2017 14:15:40 +0200
Subject: [PATCH] reset: zx2967: constify zx2967_reset_ops.
In-Reply-To: <c082e132c282634a7185ea99c50c8d671965534a.1497329415.git.arvind.yadav.cs@gmail.com>
References: <c082e132c282634a7185ea99c50c8d671965534a.1497329415.git.arvind.yadav.cs@gmail.com>
Message-ID: <1497874540.2993.67.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-06-13 at 10:22 +0530, Arvind Yadav wrote:
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     794	    232	      0	   1026	    402	drivers/reset/reset-zx2967.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>     842	    184	      0	   1026	    402	drivers/reset/reset-zx2967.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to reset/next, thank you.

regards
Philipp
