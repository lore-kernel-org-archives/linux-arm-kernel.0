From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Dec 2010 23:24:29 -0800
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=uspZY9ibQrJSti8UT1v5NHSHdzv+Y_Jsam9yu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 3:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted. ?There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.

Tegra (see comment to that specific patch for a needed fixup):

Tested-by: Olof Johansson <olof@lixom.net>
