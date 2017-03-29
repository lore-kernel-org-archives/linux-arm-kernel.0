From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 29 Mar 2017 09:38:49 +0200
Subject: [PATCH]: staging: vc04_services: fix checkpatch error
In-Reply-To: <d86e9385-55cd-1cf7-a07f-121208bd695d@gmail.com>
References: <d86e9385-55cd-1cf7-a07f-121208bd695d@gmail.com>
Message-ID: <20170329073849.GB17585@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 08:48:50AM +0300, Haim Daniel wrote:

> >From c840c64e0e662eee04b7d0403040be81eaa34c25 Mon Sep 17 00:00:00 2001
> From: Haim Daniel <haimdaniel@gmail.com>
> Date: Wed, 29 Mar 2017 08:43:46 +0300
> Subject: [PATCH] staging: vc04_services: add parenthesis to macros
> 
> vchi_cfg.h:
> 
> fix checkpatch ERROR: Macros with complex values should be enclosed in parenthesis
> ---
>  drivers/staging/vc04_services/interface/vchi/vchi_cfg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

No signed-off-by line :(
