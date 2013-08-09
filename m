From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Aug 2013 17:19:44 -0700
Subject: dw_mmc: Does anyone use multiple slots?
In-Reply-To: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
References: <CAD=FV=U3aT1KKtSwAFhYURJJerp70ij8h647=xyV51et4jYipg@mail.gmail.com>
Message-ID: <CAOesGMjaF2K0CnuWBj7xdXGAQk-XRetBstaQdd9EZzBYrmDjeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 8, 2013 at 5:16 PM, Doug Anderson <dianders@google.com> wrote:

> I guess my overall question is: if there are no actual implementations
> of multislot, shouldn't we kill it and simplify the code a whole lot?
> If someone out there has a real multislot device they can step back in
> and do it more correctly?
>
> Of course we need to find someone to actually go through and do the
> killing of multislot, but finding that person might be easier if there
> was some agreement that it was good to do.

There clearly seems to be no in-tree users of multislot. If someone
new comes in, we have the code in the history and can revert the
removal (or at least use it as reference for re-introduction).

I vote for removing it. It adds really annoying complexity for
something that nobody uses.


-Olof
