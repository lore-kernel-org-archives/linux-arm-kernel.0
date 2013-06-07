From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 15:51:10 +0200
Subject: [RFC][PATCH 3/7] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1370585013-12809-4-git-send-email-manjunath.goudar@linaro.org>
References: <1370585013-12809-1-git-send-email-manjunath.goudar@linaro.org>
 <1370585013-12809-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1527513.ZUVEWL6RFB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 11:33:29 Manjunath Goudar wrote:
> +       /*
> +       * RemoteWakeupConnected has to be set explicitly before
> +       * calling ohci_run. The reset value of RWC is 0.
> +       */

Just nitpicking, but you still use the wrong commenting style
occasionally. The '*' characters should always be aligned
vertically, like

       /*
        * RemoteWakeupConnected has to be set explicitly before
        * calling ohci_run. The reset value of RWC is 0.
        */

	Arnd
