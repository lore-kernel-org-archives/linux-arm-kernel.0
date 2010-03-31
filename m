From: julien.boibessot@free.fr (Julien Boibessot)
Date: Wed, 31 Mar 2010 15:17:36 +0200
Subject: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
In-Reply-To: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
References: <1269973921-29611-1-git-send-email-daniel@caiaq.de>
Message-ID: <4BB34B70.4030209@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Daniel Mack a ?crit :
> Add some more debug information and fix a couple of coding style things
> in mxcmmc.c.
>
> ...
>  
> @@ -512,7 +518,7 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
>  	}
>  
>  	/* For the DMA case the DMA engine handles the data transfer
> -	 * automatically. For non DMA we have to do it ourselves.
> +	 * automatically. For non DMA we have to to it ourselves.
>   
I think you introduced a typo here ("to to")...

Regards,
Julien
