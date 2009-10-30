From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 30 Oct 2009 15:16:35 +0100
Subject: [PATCH] MXC: Add support for ULPI Viewports
Message-ID: <20091030141635.GQ29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Below is a rebased version of the patch that adds ULPI viewports for
MX31 controllers. There was also a bug in the condition check for
ULPIVW_SS - && was used instead of &, a hertiage from the Freescale BSP,
which was copy'n pasted over and over again.

Daniel
