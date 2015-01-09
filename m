From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 16:43:24 +0000
Subject: [PATCH 3.19-rc2 v15 0/8] arm: Fix DEBUG_LL for multi-platform
 kernels (without PL01X)
In-Reply-To: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
References: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150109164324.GU12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 12:40:16PM +0000, Daniel Thompson wrote:
> This patchset removes some single-platform compatibility tricks related
> to DEBUG_LL and, as a result, allows multi_v7_defconfig derived builds
> to enable DEBUG_LL. Currently the user selected kbuild setting is
> ignored and the PL01X's DEBUG_LL stub is silently selected instead. This
> is a pain if your hardware doesn't have this cell, not least because it
> takes a little time to figure out that kbuild built the wrong code.

Can you put this series into the patch system so we can get some build
time regression testing for a decent period please?

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
