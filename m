From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 Mar 2011 14:15:41 -0800
Subject: [PATCH v3] OMAP3+: OPP: Replace voltage values with Macros
In-Reply-To: <1299320842-2503-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 15:57:22 +0530")
References: <1299320842-2503-1-git-send-email-nm@ti.com>
Message-ID: <874o7e1ss2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> From: Vishwanath BS <vishwanath.bs@ti.com>
>
> Since all voltage data is now centralized in oppxxx_data.c, we can replace
> the values in the opp table with the macros used for voltage values.
>
> This will avoid opp table and voltage layer having conflicting values.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

As you are now on the delivery path too, this should have your sign-off.

Assuming this is a simple oversight, I added your signoff and queued for
2.6.39 (branch: for_2.6.39/pm-misc)

Thanks,

Kevin
