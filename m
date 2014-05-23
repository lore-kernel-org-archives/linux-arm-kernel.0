From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 May 2014 15:08:37 +0200
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20140523104534.467b452b@canb.auug.org.au>
References: <20140523104534.467b452b@canb.auug.org.au>
Message-ID: <537F4855.70201@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 23/05/2014 02:45, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-mvebu/board-v7.c between commit 8ae2473d96f1 ("ARM: l2c:
> mvebu: convert to generic l2c OF initialisation") from the arm tree and
> commit 5686a1e5aa43 ("bus: mvebu: pass the coherency availability
> information at init time") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).
> 

This fix seems to be the good thing to do.

Thanks,

Gregory


> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
