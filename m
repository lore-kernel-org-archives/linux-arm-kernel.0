From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 9 Jun 2014 15:43:37 -0300
Subject: [PATCH 1/3] ARM: mvebu: clean-up unneeded kconfig selects
In-Reply-To: <1398195678-28787-2-git-send-email-robherring2@gmail.com>
References: <1398195678-28787-1-git-send-email-robherring2@gmail.com>
 <1398195678-28787-2-git-send-email-robherring2@gmail.com>
Message-ID: <20140609184337.GA9790@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 22 Apr 02:41 PM, Rob Herring wrote:
> @@ -11,7 +10,6 @@ config ARCH_MVEBU
>  	select ARCH_REQUIRE_GPIOLIB
>  	select MIGHT_HAVE_PCI
>  	select PCI_QUIRKS if PCI
> -	select OF_ADDRESS_PCI
>  

We needed that one, as Gregory introduced it specifically so we could select it
without selecting PCI.

I'll cook a patch right away, sorry for not seeing this earlier!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
