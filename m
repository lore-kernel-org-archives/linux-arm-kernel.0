From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 12:26:35 +0100
Subject: [PATCH v10 0/5] MT8173 IOMMU SUPPORT
In-Reply-To: <56D6C50B.3040108@gmail.com>
References: <1456161651-6136-1-git-send-email-yong.wu@mediatek.com>
 <20160226110633.GE22747@8bytes.org> <56D6C50B.3040108@gmail.com>
Message-ID: <15221728.nr4S7fgC2l@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 11:48:43 Matthias Brugger wrote:
> 
> On 26/02/16 12:06, Joerg Roedel wrote:
> > Hi Philipp,
> >
> > On Fri, Feb 26, 2016 at 09:55:55AM +0100, Philipp Zabel wrote:
> >> Do you have a stable branch that I could base the mediatek-drm patches
> >> on and that I may include in a pull request to be merged via drm-next?
> >
> > You can base it on the arm/mediatek branch of the iommu tree. I'll push
> > it out in the next minutes.
> >
> 
> I realized that Joerg accidentally merged the dts parts as well through 
> his branch.
> 
> As expected this patches conflict when merging the arm-soc tree.
> 
> Shall Joerg drops the patches and you take it through your branch, or
> I queue them for the next release cycle?

I think this time, we can live with the conflict, it's easy enough
to resolve when Linus pulls both branches.

	Arnd
