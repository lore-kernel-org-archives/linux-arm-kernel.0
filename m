From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 14 Jan 2013 09:45:52 -0700
Subject: [PATCH RFT 3/3] ARM: tegra: dts: seaboard: enable keyboard
In-Reply-To: <50F13C34.3020808@nvidia.com>
References: <1357911185-11048-1-git-send-email-ldewangan@nvidia.com>
 <1357911185-11048-3-git-send-email-ldewangan@nvidia.com>
 <50F09BC7.90607@wwwdotorg.org>
 <20130111232438.GN23505@n2100.arm.linux.org.uk>
 <50F09FCB.70809@wwwdotorg.org>
 <20130111233615.GO23505@n2100.arm.linux.org.uk>
 <50F0A2A8.3080401@wwwdotorg.org> <50F13C34.3020808@nvidia.com>
Message-ID: <50F43640.7060308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2013 03:34 AM, Laxman Dewangan wrote:
...
> Which is the tree on which Prashant changes are applied. I can debug
> from that tree.

git://nv-tegra.nvidia.com/user/swarren/linux-2.6 test-ccf-rework-v4

But as I said in some other email in response to Prashant, I'll go and
find out why the clk driver is returning NULL.

(Russell, while the clk API definition may allow NULL to be a legal clk
value, the actual implementation on Tegra at least doesn't consider NULL
to be a legal clk value, so it shouldn't be returned in the first
place). There's no issue here in the comprehension of the clk API.
