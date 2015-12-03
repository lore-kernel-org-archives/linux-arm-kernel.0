From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 3 Dec 2015 21:45:32 +0100
Subject: [PATCH v2 3/4] ARM: at91/dt: sama5d4: update i2c compatible string
In-Reply-To: <56601A74.3040507@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
 <56601A74.3040507@atmel.com>
Message-ID: <20151203204532.GB8509@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 11:33:24AM +0100, Nicolas Ferre wrote:
> Le 03/12/2015 10:53, Ludovic Desroches a ?crit :
> > A new compatible string has been introduced: atmel,sama5d4-i2c. It
> > allows to use the i2c-sda-hold-time-ns property if needed.
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Wolfram, we'll take this one with us in the at91 branches that will go
> into arm-soc. It'll be queued in at91-4.5-dt branch soon.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I squashed patch 1+2 now and applied them to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/404bf284/attachment.sig>
