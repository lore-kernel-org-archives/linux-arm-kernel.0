From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 20 May 2015 09:41:32 +0200
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
In-Reply-To: <20150520100851.2e485c02@canb.auug.org.au>
References: <20150520100851.2e485c02@canb.auug.org.au>
Message-ID: <555C3AAC.40101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/05/2015 02:08, Stephen Rothwell a ?crit :
> Hi Nicolas,
> 
> Today's linux-next merge of the at91 tree got a conflict in
> arch/arm/configs/multi_v7_defconfig between commit 7b57472fb6cb ("ARM:
> multi_v7_defconfig: enable asm and NEON accelerated crypto modules")
> from the arm-soc tree and commit 822cfdfb9511 ("ARM:
> multi_v7_defconfig: Add Atmel SAMA5 family") from the at91 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Fix seems perfect: thanks Stephen.

Bye,
-- 
Nicolas Ferre
