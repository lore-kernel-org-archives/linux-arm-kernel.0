From: yehuday@marvell.com (Yehuda Yitschak)
Date: Wed, 4 Jul 2012 15:11:01 +0300
Subject: [PATCH v7] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2E2747FC8980BB40958FB06A958ED3550144C11C2E54@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Monday, July 02, 2012 6:39 PM
> To: Arnd Bergmann; Olof Johansson
> Cc: Ben Dooks; Jason Cooper; Andrew Lunn; Nicolas Pitre; Lior Amsalem;
> Maen Suleiman; linux-arm-kernel at lists.infradead.org; Thomas Petazzoni;
> Gregory Clement; Jon Masters; David Marlin; Tawfik Bayouk; Shadi
> Ammouri; Eran Ben-Avi; Yehuda Yitschak; Nadav Haklai; Eric Miao
> Subject: [PATCH v7] arm: Add basic support for new Marvell Armada 370 and
> Armada XP SoC
> 
> Arnd, Olof,
> 
> You'll find in this patch set the seventh version of the initial support for a
> new family of ARMv7-compatible Marvell SoCs.
> 
> As for the previous releases, both the Armada 370 and the Armada XP SoCs
> are supported in this directory, and we are able to build a single kernel
> image that boots on both SoCs. Both SoCs use the PJ4B processor, a Marvell-
> developed ARM core that implements the ARMv7 instruction set. We are
> currently using Marvell evaluation boards for both of those SoCs, and the
> support for those boards is added in this patch set.
> 
Hi, tested by me on Armada XP board. So,
Tested-By: Yehuda Yitschak <yehuday@marvell.com>


[snip]
> 
> Best regards,
> 
> Thomas Petazzoni

Regards,
Yehuda Yitschak
