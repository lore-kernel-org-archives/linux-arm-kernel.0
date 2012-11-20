From: horms@verge.net.au (Simon Horman)
Date: Tue, 20 Nov 2012 09:03:55 +0900
Subject: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
In-Reply-To: <50AA2683.1070502@mvista.com>
References: <1353288254-6211-1-git-send-email-horms@verge.net.au>
 <1353288254-6211-2-git-send-email-horms@verge.net.au>
 <50AA2683.1070502@mvista.com>
Message-ID: <20121120000355.GB13829@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 04:30:59PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-11-2012 5:24, Simon Horman wrote:
> 
> >From: Bastian Hecht <hechtb@gmail.com>
> 
> >Since commit 3c7ea4eccfd2e
> 
>    Please also specify that commit summary in parens.

Thanks, I will fix this and re-post.

> >the sh_flctl driver requires the error IRQ line to
> >signal failed transactions between the flash controller and the NAND chip.
> >This information is mandatory - else the driver refuses to start up. We
> >provide it here for the board mackerel.
> 
> >Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> >Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
