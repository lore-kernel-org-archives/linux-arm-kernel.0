From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 22:58:00 -0700
Subject: [Git pull request] fix to the vexpress/mcpm branch
In-Reply-To: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
References: <alpine.LFD.2.03.1308121428080.14472@syhkavp.arg>
Message-ID: <20130814055800.GG16635@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On Mon, Aug 12, 2013 at 02:37:54PM -0400, Nicolas Pitre wrote:
> 
> Please pull the following:
> 
> 	git://git.linaro.org/people/nico/linux mcpm+tc2
> 
> which will update your vexpress/mcpm branch with one additional commit 
> fixing the build issue with CONFIG_FRAME_POINTER reported by RMK.  This 
> commit's SHA1 is 95fbdc9cf542.

So, I just replaced my branch with the one from Pawel, and the topmost patch
in your branch seems to no longer apply.

Would you mind rebasing on top of vexpress/mcpm in the arm-soc tree? You
can just send us the patch directly, no need to do a pull request for it.


-Olof
