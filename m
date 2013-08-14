From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 14 Aug 2013 11:30:15 +0100
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <20130814055800.GG16635@quad.lixom.net>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
 <20130814055800.GG16635@quad.lixom.net>
Message-ID: <20130814103015.GA28080@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Aug 14, 2013 at 06:58:00AM +0100, Olof Johansson wrote:
> Hi Nico,
> 
> On Mon, Aug 12, 2013 at 02:37:54PM -0400, Nicolas Pitre wrote:
> > 
> > Please pull the following:
> > 
> > 	git://git.linaro.org/people/nico/linux mcpm+tc2
> > 
> > which will update your vexpress/mcpm branch with one additional commit 
> > fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> > commit's SHA1 is 95fbdc9cf542.
> 
> So, I just replaced my branch with the one from Pawel, and the topmost patch
> in your branch seems to no longer apply.
> 
> Would you mind rebasing on top of vexpress/mcpm in the arm-soc tree? You
> can just send us the patch directly, no need to do a pull request for it.

Just as a heads-up, if Nico's fix is applied to vexpress/mcpm before this
series is pulled (it is based on top of Pawel's changes ie vexpress/mcpm)

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191369.html

the series above might not apply cleanly. Conflict is minor but might be there.
Please let me know how you want me to handle this.

Thanks,
Lorenzo
