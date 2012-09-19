From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 19 Sep 2012 09:18:19 +0800
Subject: [PATCH] USB: chipidea: use OTGSC_BSV to detect vbus valid
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803C8284B@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1347871821-14643-1-git-send-email-richard.zhao@freescale.com>
 <F281D0F91ED19E4D8E63A7504E8A649803C8284B@039-SN2MPN1-022.039d.mgd.msft.net>
Message-ID: <20120919011818.GE13530@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 04:52:59PM +0800, Chen Peter-B29397 wrote:
>  
> 
>  
> > 
> > OTGSC_AVVIS cannot be set when vbus voltage goes valid or invalid on
> > imx, so convert to use OTGSC_BSV.
> > 
> 
> Not just on imx, from the IC guys, it is chipidea's feature.
> the AVVIS will not go to 1 when the vbus goes to high if ID = 1.
Alex,

Is it ok to you? If you think the commit message is ambiguous, it could
be changed.

Thanks
Richard
 
