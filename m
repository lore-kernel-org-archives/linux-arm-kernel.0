From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Fri, 15 Mar 2013 19:47:40 +0530
Subject: DaVinci platform unable to boot via NFS
In-Reply-To: <CA+V-a8sNLBi1zB942ZbK26POrzcq7oOpNW9yPG5dG_gX7ZZ1oQ@mail.gmail.com>
References: <CA+V-a8sNLBi1zB942ZbK26POrzcq7oOpNW9yPG5dG_gX7ZZ1oQ@mail.gmail.com>
Message-ID: <51432D84.10202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2013 7:11 PM, Prabhakar Lad wrote:
> Hi Mugunthan,
>
> With 3.9 release I am not able to boot any davinci board via nfs, finally
> digging Into I found that there were recent changes for Ethernet davinci.
> Finally I reverting this to some safe commit I was able to boot via nfs.
> I reverted back as following:-
> git checkout  f9a8f83b04e0c362a2fc660dbad980d24af209fc  drivers/net/ethernet/ti/
>
> Can you please take a look at and fix it.
>
> Cheers,
> --Prabhakar Lad
> http://in.linkedin.com/pub/prabhakar-lad/19/92b/955
The issue is also reported in CPSW driver and is fixed already. I have
posted the patch for Davinci EMAC in the below link.

http://patchwork.ozlabs.org/patch/228003/

Regards
Mugunthan V N
