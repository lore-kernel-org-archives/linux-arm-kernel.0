From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Wed, 30 May 2018 22:52:46 +0200
Subject: linux-next: manual merge of the regulator tree with the arm-soc
 tree
In-Reply-To: <20180530150711.2c7c1fe9@canb.auug.org.au>
References: <20180530150711.2c7c1fe9@canb.auug.org.au>
Message-ID: <2022143.cJUAM8Fsdd@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 30, 2018 7:07:11 AM CEST Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the regulator tree got a conflict in:
> 
>   arch/arm/mach-omap1/board-ams-delta.c
> 
> between commit:
> 
>   0486738928bf ("ARM: OMAP1: ams-delta: add GPIO lookup tables")
> 
> from the arm-soc tree and commit:
> 
>   6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
> 
> from the regulator tree.
> 
> I fixed it up (see below - it may be better done) and can carry the fix
> as necessary. 

Hi Stephen,

Your fix looks pretty good to me, but anyway, I will test it and confirm in a 
day or two, as soon as I have access to the device.

Thanks,
Janusz
