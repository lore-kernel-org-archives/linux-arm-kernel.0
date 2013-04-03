From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 3 Apr 2013 17:19:16 +0300
Subject: [PATCH v8 10/14] ARM: tegra: Define Tegra114 CAR binding
In-Reply-To: <515031E3.40007@nvidia.com>
References: <1363956029-31873-1-git-send-email-pdeschrijver@nvidia.com>
 <1363956029-31873-11-git-send-email-pdeschrijver@nvidia.com>
 <515031E3.40007@nvidia.com>
Message-ID: <20130403141916.GS18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 12:15:47PM +0100, Prashant Gaikwad wrote:
> On Friday 22 March 2013 06:09 PM, Peter De Schrijver wrote:
> > The device tree binding models Tegra114 CAR (Clock And Reset) as a single
> > monolithic clock provider.
> >
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> 
> <snip>
> 
> > +  263	cclk_lp
> > +  264	dfll_ref
> > +  265	dfll_soc
> > +
> 
> Peter,
> 
> Please remove following clock IDs from binding.
> 
> > +Mux clocks
> > +

...
> > +  306	clk_out_1_mux

Is at least used by the init list. So we can't remove that?

Cheers,

Peter.
