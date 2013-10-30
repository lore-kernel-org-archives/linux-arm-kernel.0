From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Oct 2013 16:50:03 -0600
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
In-Reply-To: <20131030221833.GQ22111@tbergstrom-lnx.Nvidia.com>
References: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
 <527128B5.2020101@wwwdotorg.org>
 <20131030221833.GQ22111@tbergstrom-lnx.Nvidia.com>
Message-ID: <52718D1B.6030106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 04:18 PM, Peter De Schrijver wrote:
> On Wed, Oct 30, 2013 at 04:41:41PM +0100, Stephen Warren wrote:
>> On 10/29/2013 06:41 PM, Peter De Schrijver wrote:
>>> Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
>>> Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.
>>
>> Why? What benefit does this give, or what bug does this fix?
> 
> Otherrwise Tegra114 will crash on boot.

Sigh. For what reason?
