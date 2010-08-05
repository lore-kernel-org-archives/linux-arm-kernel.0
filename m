From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 5 Aug 2010 18:43:33 +0200
Subject: [PATCH 1/2] amba_pl022: Fix driver clock enable/disable balance
	issues
In-Reply-To: <AANLkTikvMLRfd175-1YUbsgDRm68N65YZH3DborqHcLY@mail.gmail.com>
References: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
	<1280851439-25468-2-git-send-email-wellsk40@gmail.com>
	<AANLkTikvMLRfd175-1YUbsgDRm68N65YZH3DborqHcLY@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F80AC3A54D0A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> 
> > The pl022 clock enable and disable calls can become unbalanced. This
> > code prevents clk_disable() from being called until clk_enable()
> > has been called first.
> 
> This is not for the PL022. It's for the CLCD (Is that PL220?)
> Same with the other patch...
> 

Sorry about the confusion there. Tuesday was a bit hectic!
I'll repost the series with the correct info.

kevin
