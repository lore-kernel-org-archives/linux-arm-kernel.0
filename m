From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Jan 2017 19:21:02 +0300
Subject: [PATCH] ARM: shmobile: rcar-gen2: Add more register documentation
In-Reply-To: <1484917448-8320-1-git-send-email-geert+renesas@glider.be>
References: <1484917448-8320-1-git-send-email-geert+renesas@glider.be>
Message-ID: <9d12d719-0866-a454-88e2-d51a695085cd@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 04:04 PM, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/pm-rcar-gen2.c | 40 +++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> index dd9ac366868f4336..6ed9aa19c4d34766 100644
> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> @@ -20,14 +20,30 @@
[...]
> +static inline u32 phys_to_sbar(phys_addr_t addr)
> +{
> +	return (((addr) >> 8) & 0xfffffc00);

   It's not a macro -- innermost parens not needed...

[...]

MBR, Sergei
