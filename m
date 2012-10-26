From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 19:32:58 +0000
Subject: [PATCH 0/6] Initial Calxeda ECX-2000 support
In-Reply-To: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
References: <1351276988-28382-1-git-send-email-robherring2@gmail.com>
Message-ID: <201210261932.58660.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 October 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series adds initial support for Calxeda A15 based ECX-2000 SOC. Most
> of the changes are shuffling of dts files to share common parts between
> highbank (ECX-1000) and ECX-2000 and abstracting out or removing SCU
> accesses as the A15 has no SCU registers.
> 
> Although the highbank name really refers to 1st gen SOC, the highbank
> name in the kernel is now referring to both SOCs.

The patches all look good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
