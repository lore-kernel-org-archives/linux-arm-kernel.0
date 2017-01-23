From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Jan 2017 10:46:46 -0800
Subject: [PATCH 00/18] ARM64: meson: DT cleanups
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?=
 message of "Fri, 20 Jan 2017 23:21:00 +0100")
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <m2bmux397t.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Hello,
>
> This series fixes several cosmetic issues, on top of v4.11/dt64 branch.
>
> Patches 3-5 rename a node, the rest should all be non-functional changes.

Can you respin patches 1-9 with minor comments addressed and
acks/reviews collected and I'll apply those.

> Patches 10-18 could be squashed if desired.

I'm less sure about these as I tend to agree with Rob that this is just
needless churn.  If you want to resend those separately, making your
arguments, I'll merge it if you convice the DT maintainers. :)

Kevin
