From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Mar 2011 16:27:12 +0100
Subject: Enable UART3 on TX28
In-Reply-To: <1300718213-9908-1-git-send-email-LW@KARO-electronics.de>
References: <1300718213-9908-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <201103211627.12922.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 March 2011, Lothar Wa?mann wrote:
> +       /* UART3 */
> +       MX28_PAD_AUART3_RX__AUART3_RX,
> +       MX28_PAD_AUART3_TX__AUART3_TX,
> +       MX28_PAD_AUART3_RTS__AUART3_RTS,
> +       MX28_PAD_AUART3_CTS__AUART3_CTS,
> +

The patch is missing changelog, signed-off-by and diff header.
Content-wise, it seems ok.

	Arnd
