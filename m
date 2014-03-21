From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 21 Mar 2014 16:58:42 +0100
Subject: [PATCH 1/5] clk: berlin: add support for berlin plls
In-Reply-To: <20140321154539.GD6443@piout.net>
References: <1395402220-23503-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395402220-23503-2-git-send-email-alexandre.belloni@free-electrons.com>
 <532C355C.3090606@gmail.com> <20140321154539.GD6443@piout.net>
Message-ID: <20140321155842.GG6443@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/2014 at 16:45:39 +0100, Alexandre Belloni wrote :
> > >+	.fbdiv_shift = 6,
> > >+	.rfdiv_shift = 1,
> > >+	.divsel_shift = 7,
> > 
> > Have .foo_mask and .foo_shift together?
> > 
> 
> This will make the struct larger but I don't really have an opinion.
> 

Forget that one, I'll take a break...

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
