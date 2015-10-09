From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Fri, 09 Oct 2015 13:35:55 +0200
Subject: [PATCH v4 5/8] clk: rockchip: Allow the RK3288 SPDIF clocks to
 change their parent
In-Reply-To: <11755202.f1LLWMlYi0@phil>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1444311079-2892-6-git-send-email-sjoerd.simons@collabora.co.uk>
 <11755202.f1LLWMlYi0@phil>
Message-ID: <1444390555.9895.271.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Heiko,

On Thu, 2015-10-08 at 17:10 +0200, Heiko Stuebner wrote:
> Am Donnerstag, 8. Oktober 2015, 15:31:16 schrieb Sjoerd Simons:
> > The clock branches leading to sclk_spdif and sclk_spdif_8ch on
> > RK3288
> > SoCs only feed those clocks, allow those clocks to change their
> > parents
> > all the way up the hierarchy.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> Just as comment, if I'm seeing that right, this patch needs "clk:
> rockchip: 
> handle mux dependency of fractional dividers" and friends [0] to
> apply and 
> also actually handle the fractional dividers correctly.
> 
> For the clock change itself:
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Oh sorry yes, i completely forgot to at that as note on this patch
(series). These are on top of your series as those are required to make
things actually work as expected. 

Which reminds me, i was wondering how to best move that forward. Could
you pick this one up to include it in the next round of your series?
(Otherwise i'm happy to rebase it once you do a v2)

> 
> Heiko
> 
> [0] http://lists.infradead.org/pipermail/linux-rockchip/2015-August/0
> 03930.html


-- 
Sjoerd Simons
Collabora Ltd.
