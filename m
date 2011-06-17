From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 17 Jun 2011 09:17:41 +0200
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
Message-ID: <20110617071741.GL23305@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> > I've added Wim (watchdog driver maintainer), but I would think that if
> > this change is worth doing then it should be done for all drivers.
> 
> Agreed, but today this may be more work than I'm strictly interested in
> doing. If we do decide it's the right thing then I'll look into converting the
> other drivers later.

No, we need to do it by first converting all drivers to the new API and then a
change of the API will take care of it.

Kind regards,
Wim.
