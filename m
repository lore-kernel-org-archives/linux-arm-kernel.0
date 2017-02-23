From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 23 Feb 2017 14:58:09 -0800
Subject: [PATCH 3/8] mm: cma: Export a few symbols
In-Reply-To: <20170220123550.GH2431@dhcp22.suse.cz>
References: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
 <2dee6c0baaf08e2c7d48ceb7e97e511c914d0f87.1486655917.git-series.maxime.ripard@free-electrons.com>
 <20170209192046.GB31906@dhcp22.suse.cz>
 <20170213134416.akgmtv3lv5m65fwx@lukather>
 <20170220123550.GH2431@dhcp22.suse.cz>
Message-ID: <20170223225809.rnpbjnli4wa5kims@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 01:35:50PM +0100, Michal Hocko wrote:
> On Mon 13-02-17 14:44:16, Maxime Ripard wrote:
> > Hi Michal,
> > 
> > On Thu, Feb 09, 2017 at 08:20:47PM +0100, Michal Hocko wrote:
> > > [CC CMA people]
> > > 
> > > On Thu 09-02-17 17:39:17, Maxime Ripard wrote:
> > > > Modules might want to check their CMA pool size and address for debugging
> > > > and / or have additional checks.
> > > > 
> > > > The obvious way to do this would be through dev_get_cma_area and
> > > > cma_get_base and cma_get_size, that are currently not exported, which
> > > > results in a build failure.
> > > > 
> > > > Export them to prevent such a failure.
> > > 
> > > Who actually uses those exports. None of the follow up patches does
> > > AFAICS.
> > 
> > This is for the ARM Mali GPU driver that is out of tree, unfortunately.
> 
> We do not export symbols which do not have any in-tree users.

Ok, sorry for the noise.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170223/4ea0b608/attachment.sig>
