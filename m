From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Jun 2016 00:50:44 +0000
Subject: [PATCH 03/32] irqchip: bcm2835: Avoid arch/arm-specific
 handle_IRQ.
In-Reply-To: <1464817421-8519-4-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-4-git-send-email-kraxel@redhat.com>
Message-ID: <20160602005044.GN24391@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Gerd,

On Wed, Jun 01, 2016 at 11:43:12PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> This is equivalent and works for arm64 as well.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

I don't mind taking this, or Eric's V2 resend.  However, the commit
message needs a rewrite.

thx,

Jason.
