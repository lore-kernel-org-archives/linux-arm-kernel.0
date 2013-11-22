From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Nov 2013 17:25:41 +0100
Subject: [PATCH v2] ARM: at91: sama5d3: reduce TWI internal clock frequency
In-Reply-To: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
References: <1385136523-11962-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20131122162541.GE7420@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 05:08:43PM +0100, ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> With some devices, transfer hangs during I2C frame transmission. This issue
> disappears when reducing the internal frequency of the TWI IP. Even if it is
> indicated that internal clock max frequency is 66MHz, it seems we have
> oversampling on I2C signals making TWI believe that a transfer in progress
> is done.
> 
> This fix has no impact on the I2C bus frequency.
> 
> Cc: <stable@vger.kernel.org> #3.10+
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131122/4e783c64/attachment.sig>
