From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 08 Jul 2015 14:30:09 -0700
Subject: [GIT PULL] Allwinner late changes for 4.2
In-Reply-To: <20150705203429.GA21927@lukather> (Maxime Ripard's message of
 "Sun, 5 Jul 2015 22:34:29 +0200")
References: <20150705203429.GA21927@lukather>
Message-ID: <7hk2uacp7i.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> Hi Arnd, Kevin, Olof,
>
> Here is a bunch of late patches (because I forgot about them) for the
> 4.2 merge window.
>
> They're not really controversial, are fixing some issues for the A33
> and H3 not having the reset controller initialised soon enough (by
> adding their compatible to the already existing DT machine), and the
> clock protection code not being run, resulting in the CPU (mainly)
> clock being shut down at the end of the boot.
>
> They've also been in linux-next for quite some time, so I don't expect
> any breakage from them.

Hmm, this is just a tad bit late. ;)  Even several days after we sent our own
"late" branch to Linus.  I'm afraid this is going to miss v4.2.

If there are real fixes in here, feel free to send as separate patches
and I'll queue them for v4.2-rc.

Kevin
