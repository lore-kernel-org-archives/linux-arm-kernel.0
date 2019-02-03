Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F79C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:30:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 686482177E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eFUUbIPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686482177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=D1ByK4QlT5jGLVkIRtvr+76JPvY2k1jJAc1LHh/181A=; b=eFUUbIPfrkNkb5
	Y3tsGItnpl14PDp9G3QmItqKz36oy8EEznQ8JGLUXTvge+D9PizletDfVYq6R0wcMreah5m8zvBh8
	oJ9D+3G0j+T9/WK4aeaURi9js1McL2v66IyP/VGs9a26qGlerC5qi7vwqom8dtm0Csudob4aWhBo1
	LkeWRgwhKs2fkG57XI+drVkKd5GUFdc2hFMtGdkO4YPT7QP91+yIBiLZdLLKW7gJHxacvLtUs2X7N
	bkCxG8Tp0/mWP+LV+LY6+GDcpNOQ3JlAgKE2hzJDA/AFctxWIq1f1FyYFdi/wYbWrSQEzmYrsp3h/
	jSlGW809u/sanxIN+uzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPKv-0003RJ-Hp; Sun, 03 Feb 2019 21:29:57 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPKi-0003Iq-Jh
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:29:46 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id 9ACB8440836;
 Sun,  3 Feb 2019 21:29:39 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Kevin Hilman <khilman@baylibre.com>, arm@kernel.org
Subject: [GIT PULL 1/3] ARM: defconfig: NXP LPC32xx and LPC18xx/LPC43xx
 changes for 5.1
Date: Sun,  3 Feb 2019 23:29:34 +0200
Message-Id: <20190203212936.17053-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190203_212939_658145_1DD8D44A 
X-CRM114-Status: GOOD (  11.30  )
/bin/ln: failed to access
 'reaver_cache/texts/20190203_212939_658145_1DD8D44A': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_212939_658145_1DD8D44A 
X-CRM114-Status: GOOD (  11.66  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof and Kevin,

please consider to pull the updates to NXP LPC32xx and NXP LPC18xx/LPC32xx
defconfig files, both defconfigs are now up to date to provide support of
boards maintained in the Linux kernel and savedefconfig does not produce
a difference.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/vzapolskiy/linux-lpc32xx tags/lpc32xx-defconfig-for-5.1

for you to fetch changes up to 25dc2e0bd22ecf7be552c44a71c0abe68f6a641d:

  ARM: defconfig: lpc32xx: enable DRM simple panel driver (2019-02-03 21:25:42 +0200)

----------------------------------------------------------------
ARM: lpc32xx: defconfig updates for v5.1

Here are the changes for ARM NXP LPC32xx and ARM NXP LPC18xx/LPC43xx
defconfig files:
* LPC18xx/LPC43xx and LPC32xx defconfig files got updates to match
  savedefconfig,
* PL11x LCD controller driver on both LPC18xx/LPC43xx and LPC32xx
  has been switched from fbdev to DRM one,
* drivers of GPIO controllers not found on LPC32xx boards are disabled,
* LPC32xx gets enabled additional sane debugging options: panic on oops,
  sysrq, dynamic debug, timestamps in kernel log buffer and built GDB
  scripts,
* LPC32xx gets enabled NFSv4 support,
* LPC32xx gets enabled a number of used drivers: DRM simple panel,
  fixed voltage regulator and generic SRAM drivers,
* Option to have a serial console on HS UART on LPC32xx is enabled.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: defconfig: Update LPC18xx defconfig
      ARM: defconfig: Switch LPC18xx to use PL11x DRM driver
      ARM: defconfig: Update LPC32xx defconfig
      ARM: defconfig: Switch LPC32xx to use PL11x DRM driver

Vladimir Zapolskiy (8):
      ARM: defconfig: lpc32xx: enable NFSv4 support
      ARM: defconfig: lpc32xx: enable build options for basic debugging
      ARM: defconfig: lpc32xx: enable panic on oops option
      ARM: defconfig: lpc32xx: enable serial console on HS UART
      ARM: defconfig: lpc32xx: enable generic SRAM driver
      ARM: defconfig: lpc32xx: disable superfluous GPIO controllers
      ARM: defconfig: lpc32xx: enable fixed voltage regulator support
      ARM: defconfig: lpc32xx: enable DRM simple panel driver

 arch/arm/configs/lpc18xx_defconfig | 31 ++++++++++------------
 arch/arm/configs/lpc32xx_defconfig | 65 ++++++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 52 deletions(-)

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
