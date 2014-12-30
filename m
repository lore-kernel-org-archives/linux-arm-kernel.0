From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 16:59:36 +0100
Subject: [PATCH] clocksource: arch_timer: Fix arm64 platforms not booting
In-Reply-To: <54A1BF89.70709@linaro.org>
References: <1419776431-26217-1-git-send-email-christoffer.dall@linaro.org>
 <20141229191357.GA21793@leverpostej> <54A1BF89.70709@linaro.org>
Message-ID: <1497922.CDlllKVqB4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 December 2014 21:54:33 Daniel Lezcano wrote:
> On 12/29/2014 08:13 PM, Mark Rutland wrote:
> > On Mon, Dec 29, 2014 at 08:35:09AM +0000, Christoffer Dall wrote:
> >> On Sun, Dec 28, 2014 at 09:46:20PM +0000, Marc Zyngier wrote:
> >>> What is holding this patch which, as far as I remember, has been posted
> >>> by Catalin almost three weeks ago?
> >>>
> >> I didn't find that since I didn't think I'd have to go back that long on
> >> lakml for something that breaks boot of an entire architecture.  Sorry
> >> for the confusion of a second patch, but fwiw, I now spent another few
> >> hours bisecting this, so I would really like to see this fix go into
> >> mainline ASAP as well to save others the trouble.
> >
> > Last I knew, Arnd was going to take the fix [1], which has been in
> > arm-soc's for-next and fixes branches for almost two weeks now. It
> > didn't make it into the last pull req due to some confusion over who was
> > going to take it.
> 
> I asked arm-soc team to take the fix because it was depending on a patch 
> which was already in their tree [1].

Sorry for dropping the ball on this, I've send out a pull request to Linus
now.

	Arnd
