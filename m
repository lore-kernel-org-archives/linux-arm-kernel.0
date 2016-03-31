From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 31 Mar 2016 13:09:39 -0700
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
In-Reply-To: <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
 <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
 <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
Message-ID: <20160331200939.GM39098@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 10:55:53PM +0100, Julien Chauveau wrote:
> 
> > Le 16 mars 2016 ? 15:47, Javier Martinez Canillas <javier@dowhile0.org> a ?crit :
> > 
> > Hello Andreas,
> > 
> > On Wed, Mar 16, 2016 at 8:53 AM, Andreas F?rber <afaerber@suse.de> wrote:
> >> Drop #address-cells and #size-cells, which are not required by the
> >> gpio-keys binding documentation, as button sub-nodes are not devices.
> >> 
> >> Rename sub-nodes to avoid new dtc unit address warnings when copied.
> >> 
> >> While at it, adopt the dashes convention for the node name.
> >> 
> >> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> >> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> >> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> >> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >> ---
> > 
> > Patch looks good to me.
> > 
> > Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> I agree.
> 
> Reviewed-by: Julien Chauveau <chauveau.julien@gmail.com>

Applied, thank you.

-- 
Dmitry
