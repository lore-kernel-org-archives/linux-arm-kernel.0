From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 15 Feb 2013 14:22:44 +0200
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <511D1F3F.1020309@wwwdotorg.org>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-9-git-send-email-pdeschrijver@nvidia.com>
 <511A7AB5.4040607@wwwdotorg.org>
 <20130213113807.GE3073@tbergstrom-lnx.Nvidia.com>
 <511BC3C3.6070402@wwwdotorg.org>
 <20130214100112.GH3073@tbergstrom-lnx.Nvidia.com>
 <511D1F3F.1020309@wwwdotorg.org>
Message-ID: <20130215122244.GP3073@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 06:30:39PM +0100, Stephen Warren wrote:
> On 02/14/2013 03:01 AM, Peter De Schrijver wrote:
> > On Wed, Feb 13, 2013 at 05:48:03PM +0100, Stephen Warren wrote:
> ...
> >> You still need to initialize all the UART clocks in init_table[]. This
> ...
> > Yes. The parent relationships still need to be defined. But I think that's
> > the only thing we actually need to define still?
> 
> You might want to explicitly set the rate too, if there is a divider in
> the clk module that affects it. If not, then parenting is indeed all you
> need.

Yes, for PLLs that might be useful. Device clock rates can also be set by the
driver and probably should be set by the driver.

Cheers,

Peter.
