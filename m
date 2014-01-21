From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 21 Jan 2014 09:42:18 +0200
Subject: [PATCHv13 27/40] ARM: dts: omap3 clock data
In-Reply-To: <20140120180053.GA25920@earth.universe>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <1389276051-1326-28-git-send-email-t-kristo@ti.com>
 <20140120180053.GA25920@earth.universe>
Message-ID: <52DE24DA.8050104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2014 08:00 PM, Sebastian Reichel wrote:
> Hi,
>
> I just found some time to update my SSI driver adding DT clock
> support. It works, but I wonder if the alias of the ssi clocks
> can be changed to something like the following:
>
> /* omap3430es1-clocks.dtsi */
> ssi_ick: ssi_ick_3430es1 {};
> ssi_ssr_fck: ssi_ssr_fck_3430es1 {};
> ssi_sst_fck: ssi_sst_fck_3430es1 {};
>
> /* omap36xx-omap3430es2plus-clocks.dtsi */
> ssi_ick: ssi_ick_3430es2 {};
> ssi_ssr_fck: ssi_ssr_fck_3430es2 {};
> ssi_sst_fck: ssi_sst_fck_3430es2 {};
>
> With this change I can reference the ssi clocks in omap3.dtsi
> instead of creating files for omap3430es1 and omap3430es2+.

Yea looks like a valid change to me. Feel free to send a patch for it.

-Tero
