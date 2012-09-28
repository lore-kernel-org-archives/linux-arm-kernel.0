From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Sep 2012 09:58:21 -0300
Subject: Using ipuv3 driver with device tree
In-Reply-To: <20120928123853.GJ24458@pengutronix.de>
References: <CAOMZO5CUFJ4-J90oVcNDmVLJDd4Q3xtHPKqD+BoADg7gV0gtsw@mail.gmail.com>
 <20120928123853.GJ24458@pengutronix.de>
Message-ID: <CAOMZO5C+0uYW+cGRed+W2SSPBpFPtNoq2UPOjr0oEvy5D9NuSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 9:38 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I just wanted to create some followup patches to add the devicetree
> support so that you have something to test with, but I found out
> that this is not so simple as it seems. The i.MX6 clock lookups will
> be switched to devicetree probe, but this is not in -next yet. Current
> -next is broken for me right now (haven't figured out why, but CMA
> does not work, I get not ethernet link on my babbage board,...)
> I think we'll just wait until things have settled after the merge
> window until I base further work on the IPU patches.

Understood, makes sense. Let's wait for 3.7-rc1.

Thanks,

Fabio Estevam
