From: B48286@freescale.com (Hou Zhiqiang)
Date: Thu, 15 Oct 2015 06:45:25 +0000
Subject: [v3,1/5] powerpc/fsl: Move fsl_guts.h out of arch/powerpc
In-Reply-To: <BN3PR0301MB12498818CCEA66A001228FAC843E0@BN3PR0301MB1249.namprd03.prod.outlook.com>
References: <BN3PR0301MB12498818CCEA66A001228FAC843E0@BN3PR0301MB1249.namprd03.prod.outlook.com>
Message-ID: <CY1PR0301MB07809DEB86BE03CD1FF608A98B3E0@CY1PR0301MB0780.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From patchwork Sun Sep 20 04:29:53 2015                                        
> Content-Type: text/plain; charset="utf-8"                                      
> MIME-Version: 1.0                                                              
> Content-Transfer-Encoding: 7bit                                                
> Subject: [v3,1/5] powerpc/fsl: Move fsl_guts.h out of arch/powerpc             
> From: Scott Wood <scottwood@freescale.com>                                     
> X-Patchwork-Id: 7225421                                                        
> Message-Id: <1442723397-26329-2-git-send-email-scottwood@freescale.com>        
> To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd                  
>       <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,         
>       Viresh Kumar                                                             
>       <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>         
> Cc: linux-pm at vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>,     
>       Scott Wood <scottwood@freescale.com>, linuxppc-dev at lists.ozlabs.org,     
>       linux-clk at vger.kernel.org, linux-arm-kernel at lists.infradead.org          
> Date: Sat, 19 Sep 2015 23:29:53 -0500                                          
>                                                                                
> Freescale's Layerscape ARM chips use the same structure.                       
>                                                                                
> Signed-off-by: Scott Wood <scottwood@freescale.com>                            
>                                                                                
> ---                                                                            
> v3: was patch 2/5                                                              
>                                                                                
>  arch/powerpc/include/asm/fsl_guts.h        | 192 -----------------------------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   2 +-                           
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   2 +-                           
>  arch/powerpc/platforms/85xx/p1022_ds.c     |   2 +-                           
>  arch/powerpc/platforms/85xx/p1022_rdk.c    |   2 +-                           
>  arch/powerpc/platforms/85xx/smp.c          |   2 +-                           
>  arch/powerpc/platforms/85xx/twr_p102x.c    |   2 +-                           
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   2 +-                           
>  drivers/iommu/fsl_pamu.c                   |   2 +-                           
>  include/linux/fsl/guts.h                   | 192 +++++++++++++++++++++++++++++
>  sound/soc/fsl/mpc8610_hpcd.c               |   2 +-                           
>  sound/soc/fsl/p1022_ds.c                   |   2 +-                           
>  sound/soc/fsl/p1022_rdk.c                  |   2 +-                           
>  13 files changed, 203 insertions(+), 203 deletions(-)                         
>  delete mode 100644 arch/powerpc/include/asm/fsl_guts.h                        
>  create mode 100644 include/linux/fsl/guts.h                                   

LS1043A clock driver depends on this patchset, and tested on LS1043ARDB board.

Thanks,
Zhiqiang
