From: andi@firstfloor.org (Andi Kleen)
Date: Mon, 3 Apr 2017 08:31:03 -0700
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <87pogur0y9.fsf@firstfloor.org>
 <alpine.LFD.2.20.1704021729470.1847@knanqh.ubzr>
 <CAHp75VdgEcyXPxENS87nHLtCEHqB5Z-1_T_W1opSiKqqNpeU2A@mail.gmail.com>
Message-ID: <20170403153103.GB22592@two.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> While I can agree on making Linux stuff less fatty, I can't agree on
> doing this way. We have for now two subsystems to serve for serial
> devices, you are proposing third one for only narrow class of devices.

It should be actually most (all?) real serial ones.

> From my point of view is better to achive your goal with existing
> system (as a proof of concept maybe even with ugly #ifdef:fery).

I like the idea of mintty (if it supported ptys).

Except for that (and possibly VT) it is unlikely that people really
rely on the obsolete terminal features from the 70ies. So it's a kind
of cleanup.

-Andi
