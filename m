From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 6 Mar 2013 09:52:11 +0200
Subject: [REPOST PATCH 0/2] Table lookup for mux clock type
In-Reply-To: <51368522.90700@wwwdotorg.org>
References: <1361545358-22721-1-git-send-email-pdeschrijver@nvidia.com>
 <51367625.2090405@wwwdotorg.org> <51368522.90700@wwwdotorg.org>
Message-ID: <20130306075211.GM27241@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 12:52:02AM +0100, Stephen Warren wrote:
> On 03/05/2013 03:48 PM, Stephen Warren wrote:
> > On 02/22/2013 08:02 AM, Peter De Schrijver wrote:
> >> This patchset adds a table lookup feature to the mux clock type. This will
> >> be used by the forthcoming Tegra114 clock implementation. Also instead of
> >> a fixed field width, a mask is used. This is because Tegra114 has some muxes
> >> where the parent selector is spread over several bitfields. The second patch
> >> adapts the tegra periph clock implementation which uses struct clk_mux
> >> directly.
> >>
> >> --
> >>
> >> Mike,
> >>
> >> This patch is a dependency for the Tegra114 CCF implementation. Could you
> >> review it and merge on a topic branch so Stephen can pull it in to verify
> >> the integration?
> > 
> > Peter, does this repost you resolve the issue I pointed out at:
> > http://www.spinics.net/lists/arm-kernel/msg220873.html
> 
> Indeed, I just tested applying patch 1/2 and the build is broken without
> patch 2/2.
> 
> Can you either rework the patches to maintain bisectability, or squash
> the two together?

Will squash them together.

Cheers,

Peter.
