From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 Jul 2018 09:02:15 +0530
Subject: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
In-Reply-To: <20180719032609.GV4576@dragon>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
 <20180719032454.2bxp4eil7lfaijji@vireshk-i7>
 <20180719032609.GV4576@dragon>
Message-ID: <20180719033215.ww2q5mjvgdj34wny@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-07-18, 11:26, Shawn Guo wrote:
> On Thu, Jul 19, 2018 at 08:54:54AM +0530, Viresh Kumar wrote:
> > On 19-07-18, 11:20, Shawn Guo wrote:
> > > On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > > > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > > added "operating-points" property for all CPUs, but missed i.MX7D's cpu0,
> > > > this patch adds it.
> > > > 
> > > > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > 
> > > In general, when you send a patch fixing a commit, you should have the
> > > author of that commit copied.  I added Viresh here.
> > > 
> > > It looks like a wrong fix to me.  It seems that commit b97872d4eb22
> > > shouldn't change imx7d.dtsi at all.  So the correct fix would be
> > > reverting the change on imx7d.dtsi, @Viresh?
> > 
> > Wow! Can't believe such a stupid mistake got merged and no one noticed
> > :(
> > 
> > Please revert that patch and I will resend the right fix Shawn.
> 
> Please just send a incremental fix patch for that commit.

Sure. Actually I almost wrote the patch but then realized that it
wouldn't be fair for me to send a patch for something Anson has been
working on.

@Anson: Please send a patch to remove the "operating-points" property.

-- 
viresh
