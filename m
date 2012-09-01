From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Sep 2012 18:22:34 +0000
Subject: [PATCH 1/3] ARM: move debug macros to common location
In-Reply-To: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
References: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
Message-ID: <201209011822.34824.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 August 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Based on suggestion by Russell King, create a common location for debug
> macros and select the included debug macro file using config option.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/Kconfig.debug          |    5 +++
>  arch/arm/include/debug/icedcc.S |   90 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/debug.S         |   87 ++-----------------------------------
>  arch/arm/kernel/head.S          |    4 +-
>  4 files changed, 100 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm/include/debug/icedcc.S

I haven't followed that discussion, but it sure sounds like a good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Any preference which tree to use for merging this?
