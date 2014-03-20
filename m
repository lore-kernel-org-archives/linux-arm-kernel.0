From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 13:29:42 +0000
Subject: [PATCH 1/5] mtd: st_spi_fsm: Remove useless consts from function
 arguments
In-Reply-To: <1395317630.7776.29.camel@joe-AO722>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
 <1395313907-25318-2-git-send-email-lee.jones@linaro.org>
 <1395314713.7776.17.camel@joe-AO722>
 <20140320114123.GE21349@lee--X1>
 <1395316090.7776.24.camel@joe-AO722>
 <20140320115412.GU31517@norris-Latitude-E6410>
 <20140320120307.GA9240@lee--X1>
 <1395317630.7776.29.camel@joe-AO722>
Message-ID: <20140320132942.GA6816@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Good catch. That wasn't my intention.
> > > > Why?
> > An oversight.
> 
> That's still not an explanation.
> 
> Why, unless cast away by the code itself, is
> const removal a good thing?
> 
> It does serve as an indication to a reader what
> the code does with the argument.
> 
> About the only reason I can think of arguing in
> favor of removal is inconsistent application of
> const within the module.

Your qualm is not with me in this instance. I don't ever mind holding
my hands up to mistakes I make or standing up for decisions I believe
in, but in this case I'm merely satisfying the wishes of a maintainer
I'm submitting code to.

I am strongly un-opinionated about these particular changes.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
