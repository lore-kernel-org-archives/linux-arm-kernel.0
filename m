From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Nov 2015 15:46:35 +0100
Subject: [PATCH 04/10] pwm: core: use bitops
In-Reply-To: <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <20151106144635.GA8418@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The pwm header defines bits manually while there is a nice bitops.h with
> a BIT() macro. Use the BIT() macro to set bits in pwm.h
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  include/linux/pwm.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

I don't think this is a useful change. The BIT() macro needs the same
number of characters to type at the expense of requiring an additional
include.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/e6e97c99/attachment-0001.sig>
