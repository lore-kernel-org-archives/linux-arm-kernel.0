From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed,  7 Nov 2018 15:53:47 +0100
Subject: [GIT PULL 0/3] arm64: tegra: Updates for v4.20-rc2
Message-ID: <20181107145350.29127-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

These pull requests are some follow-up changes to finally enable the
generic power domains for the Tegra XUSB block. This builds on top of
changes that were merged into v4.20-rc1, but because of some non-
trivial runtime dependencies I decided to hold back on these until
after the dust had settled.

Do you think it would be possible to merge these in for v4.20-rc2? I
realize that they are not actually fixes, but they merely add a couple
of lines to enable the power domains for XUSB as well as the
corresponding DT bindings.

Thanks,
Thierry
