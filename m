From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Wed, 16 Mar 2016 22:55:53 +0100
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
In-Reply-To: <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
References: <1458129209-15449-1-git-send-email-afaerber@suse.de>
 <CABxcv=kSax5=5mOWT7ktavFQHvdp=sxZNcJaqc=nRQN-DejnVA@mail.gmail.com>
Message-ID: <F1BB73D3-C592-4476-91A9-0529B51C2156@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Le 16 mars 2016 ? 15:47, Javier Martinez Canillas <javier@dowhile0.org> a ?crit :
> 
> Hello Andreas,
> 
> On Wed, Mar 16, 2016 at 8:53 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> Drop #address-cells and #size-cells, which are not required by the
>> gpio-keys binding documentation, as button sub-nodes are not devices.
>> 
>> Rename sub-nodes to avoid new dtc unit address warnings when copied.
>> 
>> While at it, adopt the dashes convention for the node name.
>> 
>> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Julien Chauveau <chauveau.julien@gmail.com>
>> Cc: Javier Martinez Canillas <javier@dowhile0.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
> 
> Patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

I agree.

Reviewed-by: Julien Chauveau <chauveau.julien@gmail.com>
