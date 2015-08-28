From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 29 Aug 2015 07:37:36 +1000
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
Message-ID: <1440797856.2912.239.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-08-28 at 09:02 -0500, Rob Herring wrote:

> So just keep the ibm? I'm okay with that. That would help move to
> common code. Alternatively, we could drop the vendor prefix and have
> common code just check for both.

That wouldn't be the first time we go down that path and it makes sense
imho.

> All points that could be asked of the IBM binding. Perhaps Arnd or 
> Ben can provide some insight or know who can?

They are part of the PAPR specification which we've been trying to get
published for a while now but that hasn't happened yet. Beware that
there are variants of the format based on some other property. There's
also 
"ibm,associativity-reference-points" which is used to calculate
distances. I'll see if I can get you an excerpt of the PAPR chapter, or
reword it, in the next few days (please poke me if I drop the ball next
week).

Cheers,
Ben.
