From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 20 Oct 2014 14:32:25 -0700
Subject: [PATCH v4 0/3] ARM: rk3288 : Add PM Domain support
In-Reply-To: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
 (jinkun hong's message of "Mon, 20 Oct 2014 02:03:40 -0700")
References: <1413795824-3453-1-git-send-email-jinkun.hong@rock-chips.com>
Message-ID: <7hlhoae8ba.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"jinkun.hong" <jinkun.hong@rock-chips.com> writes:

> From: "jinkun.hong" <jinkun.hong@rock-chips.com>
>
> Add power domain drivers based on generic power domain for Rockchip platform,
> and support RK3288.
>
> Based on:
> - [PATCH v1 1/4] PM / clock_ops: Add pm_clk_add_clk()
>   http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg735599.html

This series doesn't include any devices (or their clocks) being hooked
up to the power domains.  Is there another patch someplace that shows
how you add devices to the power domains (probably using DT?)

Kevin
