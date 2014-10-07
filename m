From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 7 Oct 2014 09:56:34 +0200
Subject: linux-next: manual merge of the kbuild tree with the arm-soc tree
In-Reply-To: <20141007123926.0e14810b@canb.auug.org.au>
References: <20141007123926.0e14810b@canb.auug.org.au>
Message-ID: <54339CB2.9010202@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 03:39, Stephen Rothwell :
> Hi Michal,
> 
> Today's linux-next merge of the kbuild tree got a conflict in
> arch/arm/mach-at91/Makefile between commit 91a55d4f6900 ("ARM: at91:
> introduce OLD_IRQ_AT91 Kconfig option") from the arm-soc tree and
> commit ac84eb47cc19 ("kbuild: remove unnecessary variable
> initializaions") from the kbuild tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Fix is good. Thanks Stephen.

Bye,
-- 
Nicolas Ferre
