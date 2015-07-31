From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 31 Jul 2015 09:09:16 +0200
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
In-Reply-To: <20150731083803.71c9d466@canb.auug.org.au>
References: <20150731083803.71c9d466@canb.auug.org.au>
Message-ID: <55BB1F1C.6000501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 31/07/2015 00:38, Stephen Rothwell a ?crit :
> Hi Nicolas,
> 
> Today's linux-next merge of the at91 tree got a conflict in:
> 
>   arch/arm/mach-at91/sama5.c
> 
> between commit:
> 
>   19c233b79d1a ("ARM: appropriate __init annotation for const data")
> 
> from the arm-soc tree and commit:
> 
>   a6e41317b9b8 ("ARM: at91/soc: add basic support for new sama5d2 SoC")
> 
> from the at91 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

The merge is correct. Thanks Stephen!

Bye,
-- 
Nicolas Ferre
