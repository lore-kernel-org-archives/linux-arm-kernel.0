From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Feb 2015 11:46:20 +0000
Subject: [PATCH 2/9] regulator: core: Introduce set_optimum_mode op
In-Reply-To: <CAJAp7Ogi9WePGgopCYmUYzhNtV_E8+StquK+yM1cu91e7eQNfg@mail.gmail.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20150128195204.GN21293@sirena.org.uk>
 <20150130000741.GP11960@sonymobile.com>
 <CAJAp7Ogi9WePGgopCYmUYzhNtV_E8+StquK+yM1cu91e7eQNfg@mail.gmail.com>
Message-ID: <20150206114620.GS21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 02:16:54PM -0800, Bjorn Andersson wrote:

> > I think this covers your concern about patch 3-7 as well, please let me
> > know what you think.

> Mark, any suggestions on this?

> I need a way to pass the expected current consumption from the mmc
> framework through our regulator driver to the RPM to make our eMMC
> stable.
> We can discuss the proposed "cleanups" next time we meet if you prefer.

Could you be a little more specific about what suggestions you're
looking for?  You've quoted a rather large e-mail there where you
seemed to say you were going to send a new version of the series so I
think I was expecting something to review here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150206/b87c5bd8/attachment.sig>
