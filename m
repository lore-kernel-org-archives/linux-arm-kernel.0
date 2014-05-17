From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 17 May 2014 06:22:16 +0200
Subject: [GIT PULL] at91: cleanup for 3.16 #1
In-Reply-To: <20140516232635.GB6423@quad.lixom.net>
References: <1399484042-27432-1-git-send-email-nicolas.ferre@atmel.com>
 <536A6FD7.40402@atmel.com> <20140516232635.GB6423@quad.lixom.net>
Message-ID: <20140517042216.GI29318@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/2014 at 16:26:35 -0700, Olof Johansson wrote :
> On Wed, May 07, 2014 at 07:39:35PM +0200, Nicolas Ferre wrote:
> > There is a little conflict with at91-3.16-dt that you already pulled in
> > arm-soc: here is the branch that resolves it:
> > 
> > https://github.com/at91linux/linux-at91/commits/at91-3.16-resolved
> 
> That resolution looks odd. Why is one clock under clocks { } and two of them
> are at the top level? Shouldn't they all be under the clocks subnode?
> 
> I've merged in now with your resolution, but I think this needs revisiting.
> 

Actually, all the clocks should end up at the root, please refer to:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/240219.html

I feel that was one of the topics we should have discussed at ELC but we
ended up talking about DT ABI stability instead...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
