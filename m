From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 10 Oct 2013 14:13:28 +0300
Subject: [PATCH 03/10] clk: tegra: Staticize local variables in clk-pll.c
In-Reply-To: <52542E34.6020806@wwwdotorg.org>
References: <1381231068-6053-1-git-send-email-sachin.kamat@linaro.org>
 <1381231068-6053-3-git-send-email-sachin.kamat@linaro.org>
 <52542E34.6020806@wwwdotorg.org>
Message-ID: <20131010111328.GS4233@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 06:09:24PM +0200, Stephen Warren wrote:
> On 10/08/2013 05:17 AM, Sachin Kamat wrote:
> > Local variables used only in this file are made static.
> 

Conceptually they are still exported. So I think it's counterintuitive to
declare them static. Unless you expect namespace problems, I would rather
leave it as is.

Cheers,

Peter.
