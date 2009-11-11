From: ospite@studenti.unina.it (Antonio Ospite)
Date: Wed, 11 Nov 2009 15:08:47 +0100
Subject: [PATCH 3/3] ezx: Update ezx_defconfig now that ezx-pcap is in
In-Reply-To: <1257370501-1420-1-git-send-email-ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257370501-1420-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20091111150847.a8bd6f89.ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Nov 2009 22:35:01 +0100
Antonio Ospite <ospite@studenti.unina.it> wrote:

> ---

Ah, missed the SOB line here, sorry:

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

> Resent from another place, since it looks like the previous copy has been
> lost by my ISP...
>
>  arch/arm/configs/ezx_defconfig |  947 ++++++++++++++++++++++++++++------------
>  1 files changed, 667 insertions(+), 280 deletions(-)
> 
> diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
> index d5ee16e..492f29a 100644
> --- a/arch/arm/configs/ezx_defconfig
> +++ b/arch/arm/configs/ezx_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.26-rc3
> -# Mon Jul  7 17:52:21 2008
> +# Linux kernel version: 2.6.32-rc5
> +# Mon Nov  2 13:18:50 2009
[...]

-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091111/a3c3247a/attachment.sig>
