From: broonie@kernel.org (Mark Brown)
Date: Sat, 24 May 2014 13:20:34 +0100
Subject: [PATCH v2 1/4] devicetree: bindings: Properly document micrel
 ks8851 SPI chips
In-Reply-To: <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
References: <1400875040-13269-1-git-send-email-sboyd@codeaurora.org>
 <1400875040-13269-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140524122034.GQ22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 12:57:17PM -0700, Stephen Boyd wrote:

>  Optional properties:
> -- vdd-supply:	supply for Ethernet mac
> +- vdd-supply: analog 3.3V supply for Ethernet mac
> +- vdd-io-supply: digital 1.8V IO supply for Ethernet mac
> +- reset-gpios: reset_n input pin

Are we *positive* that power is optional?  I do note that there aren't
any mandatory supplies for the device which seems very strange...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140524/50bafebb/attachment.sig>
