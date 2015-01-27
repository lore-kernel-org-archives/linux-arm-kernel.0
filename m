From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Jan 2015 15:02:18 -0800
Subject: [PATCH v3 2/4] ARM: digicolor: add low level debug support
In-Reply-To: <5b6342c716e2e56da34d7a518b49817967de948a.1421219953.git.baruch@tkos.co.il>
References: <cover.1421219953.git.baruch@tkos.co.il>
 <5b6342c716e2e56da34d7a518b49817967de948a.1421219953.git.baruch@tkos.co.il>
Message-ID: <20150127230218.GC11263@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:40:31AM +0200, Baruch Siach wrote:
> Use the USART peripheral as UART for low level debug. Only the UA0 port is
> currently supported.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/Kconfig.debug             | 12 ++++++++++--
>  arch/arm/include/debug/digicolor.S | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/include/debug/digicolor.S

Applied, thanks.

-Olof
