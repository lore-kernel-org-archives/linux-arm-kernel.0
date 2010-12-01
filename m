From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Wed, 1 Dec 2010 17:09:17 +0530
Subject: [PATCH v5] OMAP2+: PM: omap device: API's for handling
	mstandby mode
In-Reply-To: <AANLkTikvNNhNLYz9r5J5viajcRWW1zDrsfpTOK038k+C@mail.gmail.com>
References: <1290596051-12989-1-git-send-email-manjugk@ti.com>
	<AANLkTikvNNhNLYz9r5J5viajcRWW1zDrsfpTOK038k+C@mail.gmail.com>
Message-ID: <20101201113917.GA16584@GLPP-machine>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* ABRAHAM, KISHON VIJAY <kishon@ti.com> [2010-12-01 14:22:46 +0530]:

> On Wed, Nov 24, 2010 at 4:24 PM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
> > Certain errata in OMAP2+ processors will require forcing
> > master standby to "no standby" mode before completing on going
> > operation. Without this, the results will be unpredictable.
> >
[...]
> > +
> > + ? ? ? oh = *od->hwmods;
> 
>      I Guess you are missing oh++ in the following loop.

Thanks for catching this. I will fix it.

-Manjunath
