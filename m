From: viresh.kumar2@arm.com (viresh kumar)
Date: Fri, 13 Jul 2012 16:27:47 +0100
Subject: [PATCH 1/3] ARM: SPEAr3xx: Rename gpt timer clk parent name
In-Reply-To: <0275d6ccd52ace2ce8ac87f159df89ae746e82a5.1342181727.git.vipulkumar.samar@st.com>
References: <cover.1342181727.git.vipulkumar.samar@st.com>
 <0275d6ccd52ace2ce8ac87f159df89ae746e82a5.1342181727.git.vipulkumar.samar@st.com>
Message-ID: <50003E73.3040403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/12 13:21, Vipul Kumar Samar wrote:
> As pll3_48m_clk clock is renamed like pll3_clk so make corresponding changes for
> gpt parent clock name.

Do, this as part of clk patch only.

> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  arch/arm/mach-spear3xx/spear3xx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
> index 0f41bd1..66db5f1 100644
> --- a/arch/arm/mach-spear3xx/spear3xx.c
> +++ b/arch/arm/mach-spear3xx/spear3xx.c
> @@ -87,7 +87,7 @@ void __init spear3xx_map_io(void)
>
>  static void __init spear3xx_timer_init(void)
>  {
> -     char pclk_name[] = "pll3_48m_clk";
> +     char pclk_name[] = "pll3_clk";
>       struct clk *gpt_clk, *pclk;
>
>       spear3xx_clk_init();
>


--
Viresh



-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
