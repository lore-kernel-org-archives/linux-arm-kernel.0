From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 23:04:28 -0700
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC DT Updates for
 v3.16
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <20140520060428.GS18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 09:58:16AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these third round of Renesas ARM based SoC DT updates for v3.16.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt2-for-v3.16,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 5a62ec57004f1a434bfd3feed43e447b5780baf6:
> 
>   ARM: shmobile: henninger: enable SATA0 (2014-04-28 09:12:04 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt3-for-v3.16
> 
> for you to fetch changes up to 3fa3985e624aea24334abc9a33b484c3d316e64e:
> 
>   ARM: shmobile: r8a7740 dtsi: Remove duplicate interrupt-parent property (2014-05-15 08:09:59 +0900)
> 
> ----------------------------------------------------------------
> Third Round of Renesas ARM Based SoC DT Updates for v3.16
> 
> r8a7791 (R-Car M2), r8a7779 (R-Car H1), r8a7778 (R-Car M1),
> r8a7740 (R-Mobile A1) and r8a73a4 (R-Mobile APE6) SoCs
> * Move interrupt-parent property to root node
> 
> r8a7791 (R-Car M2) and r8a7790 (R-Car H2) SoCs
> * Add GPIO clocks
> 
> r8a7791 (R-Car M2) based Henninger board
> * Add MSIOF0, QSPI and SDHI0/2 support
> * Specify EXTAL frequency
> 
> r8a7779 (R-Car H1) based Marzen board
> * Set SMSC lan to use irq-push-pull
> 
> r8a7740 (R-Mobile A1) SoC
> * Remove duplicate interrupt-parent property
> 
> r8a7740 (R-Mobile A1) based Armadillo800 EVA board
> * Add Ethernet support

Merged into next/dt.

You can shorten down the tag texts a bit if you want, right now they
mostly duplicate what's in the shortlog already.


Thanks,

-Olof
