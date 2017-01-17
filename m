From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 14:53:23 -0800
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20170118094929.7d79bb55@canb.auug.org.au>
References: <20170118094929.7d79bb55@canb.auug.org.au>
Message-ID: <e76ccd27-ce3b-d9e3-42c7-80586c34de18@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 02:49 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in:
> 
>   arch/arm/mach-ux500/platsmp.c
> 
> between commit:
> 
>   6996cbb23721 ("ARM: 8641/1: treewide: Replace uses of virt_to_phys with __pa_symbol")
> 
> from the arm tree and commit:
> 
>   9e634cae7256 ("ARM: ux500: simplify secondary boot")
> 
> from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Your resolution looks correct, thanks Stephen!
-- 
Florian
