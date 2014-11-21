From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Nov 2014 19:08:00 +0100
Subject: [PATCH 1/2] i2c: at91: remove legacy DMA support
In-Reply-To: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141121180800.GB3754@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 02:44:31PM +0100, Ludovic Desroches wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Since at91sam9g45 is now DT-only, all DMA capable users of this driver
> are using the DT case, and the legacy support can be removed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/42ca942c/attachment.sig>
