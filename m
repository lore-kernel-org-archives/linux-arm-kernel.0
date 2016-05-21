From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 21 May 2016 12:55:56 +0100
Subject: [PATCH 0085/1529] Fix typo
In-Reply-To: <20160521114759.3760-1-andrea.gelmini@gelma.net>
References: <20160521114759.3760-1-andrea.gelmini@gelma.net>
Message-ID: <20160521115556.GV19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 21, 2016 at 01:47:59PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/arm/include/asm/ucontext.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
> index 14749ae..b4d2d0f 100644
> --- a/arch/arm/include/asm/ucontext.h
> +++ b/arch/arm/include/asm/ucontext.h
> @@ -8,7 +8,7 @@
>   * ucontext now has room for all registers which need to be saved and
>   * restored.  Coprocessor registers are stored in uc_regspace.  Each
>   * coprocessor's saved state should start with a documented 32-bit magic
> - * number, followed by a 32-bit word giving the coproccesor's saved size.
> + * number, followed by a 32-bit word giving the coprocessor saved size.

The original is fine, and I'd say is more correct.

"coprocessor's saved size" "saved size of the coprocessor".  The
apostrophe here is the possessive apostrophe.

http://www.grammarbook.com/punctuation/apostro.asp

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
