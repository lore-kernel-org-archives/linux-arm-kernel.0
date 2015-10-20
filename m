From: geoff@infradead.org (Geoff Levand)
Date: Tue, 20 Oct 2015 12:05:14 -0700
Subject: [PATCH 0/2] arm64: kexec/kdump fixes for v10
In-Reply-To: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1445367914.30908.87.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2015-10-20 at 16:58 +0900, AKASHI Takahiro wrote:
> These patches should be applied on top of Geoff's kexec/kdump patch[1],
> v10, to fix some issues.

I folded these fixes into my series as v10.1.

-Geoff


The following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git kexec-v10.1

for you to fetch changes up to 5d4425b5ada84207b18a598f2199a67bc94fb141:

  arm64: kdump: relax BUG_ON() if more than one cpus are still active (2015-10-20 09:59:53 -0700)

----------------------------------------------------------------
