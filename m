From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Jul 2013 14:38:25 +0200
Subject: [PATCH v3 2/8] clk: samsung: pll: Add support for PLL6552 and
 PLL6553
In-Reply-To: <20130728123051.GQ9858@sirena.org.uk>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <11551938.yDBcNngaZN@flatron> <20130728123051.GQ9858@sirena.org.uk>
Message-ID: <3758744.oOA9YxCvpA@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 of July 2013 13:30:51 Mark Brown wrote:
> On Wed, Jul 24, 2013 at 01:52:19AM +0200, Tomasz Figa wrote:
> > Changes since v2:
> >  - Reworked to use new PLL registration method introduced by Yadwinder
> >  
> >    Singh Brar's patch series:
> >    ( http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20041 )
> 
> I'm not able to test this series since that lot isn't in -next and I
> didn't get a copy.

Hmm, I wonder what happened with that series, as Mike was supposed to
try applying it to clk tree [1].

Mike, could you shed some light on this?

Best regards,
Tomasz

[1] http://thread.gmane.org/gmane.linux.kernel.samsung-soc/20041/focus=21003
