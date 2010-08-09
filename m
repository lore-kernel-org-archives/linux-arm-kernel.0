From: peter.pearse@arm.com (Peter Pearse)
Date: Mon, 9 Aug 2010 10:11:02 +0100
Subject: [PATCH 2/2] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTiki_69rgDCrMGtYwNmsp35EYiUedbLnYM_dvv+a@mail.gmail.com>
References: <1277811391-17966-1-git-send-email-linus.walleij@stericsson.com>	<AANLkTi=jStVGbJC7jUyhOG3og14F58rw+LEN2UqnP-X0@mail.gmail.com>	<AANLkTi=bkp+JJYQ7dF36Up3gcjJR8LypgfKBWZHLfPH-@mail.gmail.com>	<AANLkTimPAeupEKwksBKOyWX8K+wHgmgc5vEJ8cXBsQtD@mail.gmail.com>	<AANLkTi=yJjHDh08muCg7Z97xRGDcTQrv=VimHSNCqn2U@mail.gmail.com>	<20100805071235.GA436@morgana.i.gnudd.com>	<AANLkTinAuZ5GAauKHfUVV_K_9gQOpFY35m7SLsH6rvD1@mail.gmail.com>	<AANLkTi=OLP+NwGP7v0O0=ZqBNp_Ag9mm+LEUnCw5OX7L@mail.gmail.com>
	<AANLkTiki_69rgDCrMGtYwNmsp35EYiUedbLnYM_dvv+a@mail.gmail.com>
Message-ID: <000001cb37a2$ca081cb0$9644010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus

Barriers probably just me being ultra cautious

Given you've tested on multicore, feel free to remove them

Peter 

> -----Original Message-----
> From: Linus Walleij [mailto:linus.ml.walleij at gmail.com] 
> Sent: 06 August 2010 23:55
> To: Dan Williams
> Cc: Alessandro Rubini; Peter Pearse; viresh.kumar at st.com; 
> linux-arm-kernel at lists.infradead.org; 
> linux-kernel at vger.kernel.org; yuanyabin1978 at sina.com; 
> ben-linux at fluff.org; kgene.kim at samsung.com; rmk at arm.linux.org.uk
> Subject: Re: [PATCH 2/2] DMAENGINE: driver for the ARM 
> PL080/PL081 PrimeCells
> 
> 2010/8/6 Dan Williams <dan.j.williams@intel.com>:
> 
> >?One
> > thing that should be on the todo list is to review the 
> usage of memory  
> >barriers. ?I don't think they are serving the purpose that 
> you think  
> >they are.
> 
> All of those are from Peters original implementation, I never 
> use any barriers so they actually looked alien to me. Unless 
> I get a clear rationale from Peter I'll just remove them all 
> for the time being in the fix-up version due after updating 
> to generic slave control.
> 
> Yours,
> Linus Walleij
> 
