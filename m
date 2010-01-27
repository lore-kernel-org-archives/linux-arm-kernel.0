From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jan 2010 11:12:51 +0000
Subject: [PATCH 2/4] mfd: update irq handler in max8925
In-Reply-To: <771cded01001262202s45f28206hd9740279a275898e@mail.gmail.com>
References: <771cded01001250308mfd2b3d2l76bc2a2df88e7b93@mail.gmail.com>
	<20100125115930.GE22909@sirena.org.uk>
	<771cded01001251912q67c9c2a5w3db61e9d7fe53cf9@mail.gmail.com>
	<20100126112800.GL15759@rakim.wolfsonmicro.main>
	<771cded01001260331u541cc931x361d0719cd8fe00@mail.gmail.com>
	<20100126120602.GP15759@rakim.wolfsonmicro.main>
	<771cded01001262202s45f28206hd9740279a275898e@mail.gmail.com>
Message-ID: <20100127111251.GH22551@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 01:02:09AM -0500, Haojian Zhuang wrote:

> Updated patch is attached in mail. Now the modification is in below.
> 1. remove clear_irq() & clear_tsc_irq().
> 2. remove warning message in max8925_irq().

This looks OK for me - for what it's worth

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
