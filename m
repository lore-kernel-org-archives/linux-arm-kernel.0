From: carlo@caione.org (Carlo Caione)
Date: Thu, 28 Aug 2014 09:51:15 +0200
Subject: [PATCH 2/7] ARM: meson: serial: add MesonX SoC on-chip uart driver
In-Reply-To: <1408272594-10814-3-git-send-email-carlo@caione.org>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-3-git-send-email-carlo@caione.org>
Message-ID: <20140828075115.GA2601@carlo-MacBookPro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 12:49:49PM +0200, Carlo Caione wrote:
> The SoC has four fully functional UARTs which use the same programming
> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> which cannot be powered off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---

<cut>

Hi,
Any feedback on this patch before submitting v2?

Thanks,

-- 
Carlo Caione
