From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 10 Jun 2016 17:10:20 +0200
Subject: [PATCH] ARM: at91: debug: add default DEBUG_LL addresses
In-Reply-To: <1465386548-9757-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465386548-9757-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160610151020.GE19050@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2016 at 13:49:08 +0200, Alexandre Belloni wrote :
> Add configuration options for the most commonly used UART physical and
> virtual addresses to ease the use of DEBUG_LL and earlyprintk.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/Kconfig.debug | 58 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
Applied now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
