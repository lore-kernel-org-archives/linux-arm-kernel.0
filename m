From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Mon, 17 Feb 2014 11:16:58 -0800
Subject: [PATCH v3] input: sirfsoc-onkey - report onkey untouch event by
 detecting pin status
In-Reply-To: <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com>
References: <1392348001-4950-1-git-send-email-21cnbao@gmail.com>
 <20140214075717.GA14682@core.coreip.homeip.net>
 <CAGsJ_4xqnZAO6vpkgTEHmfp9+nbWa1qwQ4pda6B2sSrEtbV3ZA@mail.gmail.com>
 <847BC5012124A94BB5CA1B26E022CCA3012BAFDC27@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAGsJ_4zjtWV3Z1AJ2bqekXn54rm=k8d4iOi_zzainCEnNGefCw@mail.gmail.com>
Message-ID: <20140217191658.GA19223@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 09:41:06PM +0800, Barry Song wrote:
> >> Input: sirfsoc-onkey - implement open and close methods
> >>
> >> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >>
> >> We can control whetehr device generates interrupts or not so let's
> >> implement open and close methods of input device so that we do not do any
> >> processing until there are users.
> >>
> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Tested-by: Xianglong Du <Xianglong.Du@csr.com>
> 
> Dmitry, will you push this one to your tree so that i can rebase others?

I rebased and pushed everything out, please take a look to make sure it
all looks good.

Thanks.

-- 
Dmitry
