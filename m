From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 27 Oct 2015 13:21:48 +0100
Subject: [PATCH] regulator: tps65217: remove tps65217.dtsi file
In-Reply-To: <1445850836-17863-1-git-send-email-hs@denx.de>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
Message-ID: <20151027122148.GA819@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
> remove tps65217.dtsi and adapt all boards, which
> used it.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> Suggested by Mark Brown, see:
> https://lkml.org/lkml/2015/10/21/581
> 
>  .../devicetree/bindings/regulator/tps65217.txt     | 78 ----------------------

why did you delete the binding description?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/e0ee50ca/attachment-0001.sig>
