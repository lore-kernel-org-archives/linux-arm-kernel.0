From: olof@lixom.net (Olof Johansson)
Date: Wed, 26 Jun 2013 15:57:14 -0700
Subject: [PATCH] ARM: Make multi_v7_defconfig usable on hardware
In-Reply-To: <CAOesGMg2du8PsOGy1kdePT4vMsWie1N8hmjCxRqr-LS6RAC07g@mail.gmail.com>
References: <1372210565-22962-1-git-send-email-olof@lixom.net>
 <CAOesGMg2du8PsOGy1kdePT4vMsWie1N8hmjCxRqr-LS6RAC07g@mail.gmail.com>
Message-ID: <20130626225714.GB911@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 06:38:21PM -0700, Olof Johansson wrote:
> On Tue, Jun 25, 2013 at 6:36 PM, Olof Johansson <olof@lixom.net> wrote:
> 
> > +CONFIG_DEBUG_LL=y
> > +CONFIG_DEBUG_OMAP2PLUS_UART=y
> > +CONFIG_DEBUG_OMAP4UART3=y
> 
> Clearly not supposed to be there for the posted version, my bad --
> will take those out before committing.
> 
> (this will go on top of next/late, btw).

Actually, this doesn't go nicely on top of any branch right now since
multi_v7_defconfig is modified in several of the branches.

So, I've applied this on top of for-next (which is unorthodox and unusual), and
we'll move it over to what will likely be the first, pre-rc1 fixes pull request
that we send up, once all the other contents has been merged.


-Olof
