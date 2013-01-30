From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Jan 2013 09:01:34 +0000
Subject: [BUG] snowball board locks up on boot
In-Reply-To: <CACRpkdZU80XB2GiDtc7nh0hgMpyVYesi+xwhndu50jGS1L=wiw@mail.gmail.com>
References: <1359047682.21576.154.camel@gandalf.local.home>
 <CACRpkdZU80XB2GiDtc7nh0hgMpyVYesi+xwhndu50jGS1L=wiw@mail.gmail.com>
Message-ID: <20130130090134.GR18212@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I tried to get my snowball board working on the latest kernel, but it
> > locks up hard very early on boot up.
> >
> > I bisected it down to this commit:
> >
> > commit ebc96db7632f987e0b9bffcb782cf5cfb8afb0dd
> > Author: Ulf Hansson <ulf.hansson@linaro.org>
> > Date:   Mon Aug 27 15:45:53 2012 +0200
> >
> >     ARM: ux500: Switch to use common clock framework
> 
> Yeah the new common clock framework is a bit like a heart
> transplant on the platforms you convert, some fallout is expected.
> 
> However I thought we had all the clk fixes covered by -rc4 :-(
> 
> I don't have a Snowball right now myself, so have to ask
> for help here (non snowball ux500's work just fine for me).
> 
> Lee, are you still booting the Snowball on new kernels
> everyday, and do you know if some fix is still missing?

Can you provide your bootlog please Steven?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
