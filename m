From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 03 Jul 2012 18:20:40 +0100
Subject: [PATCH v7] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FF329E8.8080702@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/12 16:39, Thomas Petazzoni wrote:
> Arnd, Olof,
>
> You'll find in this patch set the seventh version of the initial
> support for a new family of ARMv7-compatible Marvell SoCs.
>
> As for the previous releases, both the Armada 370 and the Armada XP
> SoCs are supported in this directory, and we are able to build a
> single kernel image that boots on both SoCs. Both SoCs use the PJ4B
> processor, a Marvell-developed ARM core that implements the ARMv7
> instruction set. We are currently using Marvell evaluation boards for
> both of those SoCs, and the support for those boards is added in this
> patch set.
>
> We remained focused on a limited preliminary support which only
> includes the necessary code for timer and IRQ support, the serial
> controller is a standard 16550-compatible one. The diffstat looks
> like:

I've built and it got to looking for a root-fs.

Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>

I will have another run through the series tomorrow and do a last
pass review.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
