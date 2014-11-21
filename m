From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Nov 2014 19:08:05 +0100
Subject: [PATCH 2/2] i2c: at91: enable probe deferring on dma channel
 request
In-Reply-To: <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
 <1416577472-24542-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20141121180805.GC3754@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 02:44:32PM +0100, Ludovic Desroches wrote:
> If dma controller is not probed, defer i2c probe.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/d9727223/attachment.sig>
