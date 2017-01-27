From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 27 Jan 2017 10:16:52 +0100
Subject: [PATCH 0/2] memory: atmel-ebi: Fixes
In-Reply-To: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485508237-30178-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170127091652.bwa3tploi66fdyj4@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/2017 at 10:10:35 +0100, Boris Brezillon wrote:
> Hello,
> 
> Here are 2 simple EBI fixes to prepare landing of the Atmel NAND
> controller driver and bindings rework.
> 
> No need to backport them since no one is using the EBI right now.
> 
> Nicolas, Alexandre, that'd be great if you could queue it for 4.11
> since I plan to take the NAND driver rework for 4.12. If that's not
> possible, I'll probably ask you to let me take these fixes into the
> NAND tree.
> 
> Thanks,
> 
> Boris
> 
> Boris Brezillon (2):
>   memory: atmel-ebi: Fix the test to enable generic SMC logic
>   memory: atmel-ebi: Properly handle multiple reference to the same CS
> 
>  drivers/memory/atmel-ebi.c | 48 +++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
