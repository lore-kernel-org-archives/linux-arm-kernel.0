From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 15:19:24 +0200
Subject: [PATCH] ARM/EP93xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <20150810090334.GB5766@linux>
References: <744dca162a7626694770a9f51457566a33c3e08f.1438852023.git.viresh.kumar@linaro.org>
 <CACRpkdZknzqgH+-F0MZgZywtoOL1hhbg=7w1RSC5aZohXtDB3A@mail.gmail.com>
 <20150810090334.GB5766@linux>
Message-ID: <20150811131924.GJ30181@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 02:33:34PM +0530, Viresh Kumar wrote:
> On 10-08-15, 11:01, Linus Walleij wrote:
> > Sure, but does it work right off or does Olof have to
> > pull a branch from your tree in for it to work? In that
> > case I suggest you take this in the -rc phase. Anyways:
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> It should work with latest 4.2 rc..

Latest? We don't base our tree on the latest -- instead we try to keep
back on -rc2/3 if we can. Right now our tree is on -rc2.


Please confirm that this is still OK to merge with that as base. Thanks.


-Olof
