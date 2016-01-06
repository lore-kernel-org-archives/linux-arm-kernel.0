From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 6 Jan 2016 09:51:18 +0100
Subject: [PATCH v2] ARM: shmobile: gose: add i2c2 bus to device tree
In-Reply-To: <1451945780-17558-1-git-send-email-horms+renesas@verge.net.au>
References: <1451945780-17558-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160106085118.GF1525@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 09:16:20AM +1100, Simon Horman wrote:
> Activate i2c2 bus in r8a7793/gose device tree.
> 
> Based on similar work for the r8a7791/koelsch by Wolfram Sang.
> 
> Cc: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> * Update eprom compat strings to "renesas,r1ex24002", "atmel,24c02".
>   The former needs to be documented once the desired mechanism
>   for documenting eprom compat strings has been confirmed
>   with the maintainer.

I'll take care of this now.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/e38b612e/attachment.sig>
