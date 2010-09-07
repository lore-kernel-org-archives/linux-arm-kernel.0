From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 07 Sep 2010 16:18:51 -0400
Subject: Git pull request: disable Neon on old i.MX51
Message-ID: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you please pull:

	git://git.linaro.org/kernel/linux-linaro-next.git for_rmk

This contains 2 patches to allow i.MX51 code to disable Neon on those
revisions where it is broken, and so in a generic way.  Those patches
are following in subsequent emails.  This is based on v2.6.35.

[PATCH 1/2] ARM: link board specific files after core files
[PATCH 2/2] ARM: mxc: turn off HWCAP_NEON for older versions of imx51 silicon


Nicolas
