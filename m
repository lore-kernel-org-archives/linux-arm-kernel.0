From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 23 Dec 2013 16:18:52 +0200
Subject: [PATCH Resend 2/7] clk: tegra: Staticize
 tegra_clk_periph_nodiv_ops
In-Reply-To: <52B3265F.8080901@wwwdotorg.org>
References: <1387443241-5694-1-git-send-email-sachin.kamat@linaro.org>
 <1387443241-5694-2-git-send-email-sachin.kamat@linaro.org>
 <52B3265F.8080901@wwwdotorg.org>
Message-ID: <20131223141852.GD3378@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 06:01:19PM +0100, Stephen Warren wrote:
> On 12/19/2013 01:53 AM, Sachin Kamat wrote:
> > tegra_clk_periph_nodiv_ops is used only in this file. Make it static.
> 
> I believe that Peter De Schrijver is picking up patches for
> drivers/clk/tegra and sending pull requests to Mike. Hence, I'm CC'ing
> him in here.
> 

This seems to be already merged in next-20131223 as 4e100354e5b7c8982d1563dca134d375979a8ead

Cheers,

Peter.
