From: mporter@ti.com (Matt Porter)
Date: Fri, 12 Oct 2012 07:54:37 -0400
Subject: [RFC PATCH v2 08/16] ARM: omap: add hsmmc am33xx specific init
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EAA6374@DBDE01.ent.ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
 <1349982281-10785-9-git-send-email-mporter@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EAA6374@DBDE01.ent.ti.com>
Message-ID: <20121012115437.GG13724@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 09:17:53AM +0000, Hebbar, Gururaja wrote:
> Matt
> 
> On Fri, Oct 12, 2012 at 00:34:33, Porter, Matt wrote:
> > AM33xx requires special handling in hsmmc initialization
> > platform glue.
> 
> Since AM335x boots mainly through DT, do we still need this patch.
> This function will be called in case of initializing hsmmc with
> Platform data. 

Yes, thanks, will drop in v3.

-Matt
