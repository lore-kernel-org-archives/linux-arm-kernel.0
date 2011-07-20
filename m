From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Jul 2011 13:05:39 +0200
Subject: [PATCH 5/7] ehci mxc: make it more flexible to be used for mx28
In-Reply-To: <1311160106-4898-6-git-send-email-tony.lin@freescale.com> (Tony
	Lin's message of "Wed, 20 Jul 2011 19:08:24 +0800")
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-6-git-send-email-tony.lin@freescale.com>
Message-ID: <874o2hp5z0.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lin <tony.lin@freescale.com> writes:
Hi,

> old driver uses some hard coding for clks' name which could
> not be used for mx28. So workaround these hard codings by
> judging the cpu is mx28 or not.

Sascha had some patches to solve this in a different way, avoiding to
add yet an other cpu_is_* check for ahb clock. Don't know their current
status.

See:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/040364.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/040365.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/040363.html

Arnaud
