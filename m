From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Jun 2013 16:46:33 +0100
Subject: [PATCH 00/10] regulator: ab8500-ext: Refactorings
In-Reply-To: <20130610152507.GF1403@sirena.org.uk>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdbygDNdsO=EzigPiBSnMmF-NVnF95HeBBavkry93i+ubQ@mail.gmail.com>
 <20130610151208.GK20297@gmail.com>
 <20130610152507.GF1403@sirena.org.uk>
Message-ID: <20130610154633.GL20297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Jun 2013, Mark Brown wrote:

> On Mon, Jun 10, 2013 at 04:12:08PM +0100, Lee Jones wrote:
> 
> > The 'ux500: regulator_supply' patch, relies on the 'regulator:
> > supply_name' one however. Mark has taken two of them, I don't know why
> > the others were missed/intentionally left.
> 
> > Mark, was there a reason for this?
> 
> IIRC they were more involved and since you decided to pick a random
> e-mail address to send them to that goes nowhere near the mailboxes I
> use for upstream they're not going to bubble up particularly quickly.

Not as random as you might think.

I knew you'd left your old place, so I did:

  `git log --author="Mark Brown" --format=%ae next/master | uniq -c | head`

... to see what you were using most recently. I recieved:

     67 broonie at linaro.org
      1 broonie at kernel.org
      1 broonie at linaro.org
     59 broonie at opensource.wolfsonmicro.com
     28 broonie at sirena.org.uk
    763 broonie at opensource.wolfsonmicro.com
      1 broonie at sirena.org.uk
    428 broonie at opensource.wolfsonmicro.com
      1 broonie at sirena.org.uk
     23 broonie at opensource.wolfsonmicro.com

... hence why I used your linaro address.

I'll send it out again to your kernel.org one if it make you happy. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
