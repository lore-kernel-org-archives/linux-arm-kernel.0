Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B327C20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o9Et/jWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B327C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qhM1SsHcD6KY+lQzyOtEBUrf6WhYjCeSKwsUuYDzQik=; b=o9Et/jWD6cgzaz
	Qpo3pMIqJdobNW5V2WM5fL+bmqS1jbwhlqtrvSyUzwZzwNzIUyi2lCfLts1D+nt+1v889sV2FIBKH
	vGu63mbRZ1Jqn9xb/vUAxNDYNuAnssQCMsYabbYmMoAXDsjGsh8zpWji0GE3rkOnutJ5ZDLgUOldZ
	k3onkjy39sxDrJMIjiDOjFcDoeQwfYikEVlTqAsW1QsaPw5cx05rmtqQJ2+CaFK7A3+VTtrzp+f30
	n8uCL6Y5JRgOE89WH+gUHC9VqKHk/29pPxvlzdMZ0iQOaxe9Qs8OxtzhOQCCM9T/qCYeJmfxLIImv
	EH26kaeqG/ClBnCsG0pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUt1z-0004Uw-Q9; Thu, 06 Dec 2018 12:45:27 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUt1t-0004En-0B
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 12:45:25 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Dec 2018 04:45:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,322,1539673200"; d="scan'208";a="299855502"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 06 Dec 2018 04:45:08 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gUt1g-0001Xb-GP; Thu, 06 Dec 2018 20:45:08 +0800
Date: Thu, 6 Dec 2018 20:44:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [shawnguo:imx/soc 2/2] arch/arm/Kconfig.debug:1445: syntax error
Message-ID: <201812062028.Xnf6p6GZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_044521_090884_B074F35E 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Shawn Guo <shawnguo@kernel.org>, kbuild-all@01.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git imx/soc
head:   911dccedb00e5b45cf2d0fafc21aba233b58e115
commit: 911dccedb00e5b45cf2d0fafc21aba233b58e115 [2/2] ARM: debug-imx: only define DEBUG_IMX_UART_PORT if needed
config: arm-hackkit_defconfig
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 911dccedb00e5b45cf2d0fafc21aba233b58e115
        GCC_VERSION=7.2.0 make.cross ARCH=arm  hackkit_defconfig
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/Kconfig.debug:1445: syntax error
>> arch/arm/Kconfig.debug:1444: invalid option
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
>> lib/Kconfig.debug:1: missing end statement for this entry
>> arch/arm/Kconfig.debug:1445: invalid statement
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446: invalid statement
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447: invalid statement
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448: invalid statement
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449: invalid statement
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450: invalid statement
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451: invalid statement
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452: invalid statement
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453: invalid statement
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454: invalid statement
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455: invalid statement
   arch/arm/Kconfig.debug:1456: invalid statement
>> arch/arm/Kconfig.debug:1457: unexpected option "default"
   arch/arm/Kconfig.debug:1458: invalid statement
   arch/arm/Kconfig.debug:1459: invalid statement
   arch/arm/Kconfig.debug:1460:warning: ignoring unsupported character '.'
   arch/arm/Kconfig.debug:1460: invalid statement
>> lib/Kconfig.debug:2049: unexpected end statement
   make[2]: *** [hackkit_defconfig] Error 1
   make[1]: *** [hackkit_defconfig] Error 2
   make: *** [sub-make] Error 2
--
>> arch/arm/Kconfig.debug:1445: syntax error
>> arch/arm/Kconfig.debug:1444: invalid option
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
>> lib/Kconfig.debug:1: missing end statement for this entry
>> arch/arm/Kconfig.debug:1445: invalid statement
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446: invalid statement
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447: invalid statement
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448: invalid statement
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449: invalid statement
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450: invalid statement
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451: invalid statement
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452: invalid statement
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453: invalid statement
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454: invalid statement
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455: invalid statement
   arch/arm/Kconfig.debug:1456: invalid statement
>> arch/arm/Kconfig.debug:1457: unexpected option "default"
   arch/arm/Kconfig.debug:1458: invalid statement
   arch/arm/Kconfig.debug:1459: invalid statement
   arch/arm/Kconfig.debug:1460:warning: ignoring unsupported character '.'
   arch/arm/Kconfig.debug:1460: invalid statement
>> lib/Kconfig.debug:2049: unexpected end statement
   make[2]: *** [oldconfig] Error 1
   make[1]: *** [oldconfig] Error 2
   make: *** [sub-make] Error 2
--
>> arch/arm/Kconfig.debug:1445: syntax error
>> arch/arm/Kconfig.debug:1444: invalid option
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1445:warning: ignoring unsupported character '|'
>> lib/Kconfig.debug:1: missing end statement for this entry
>> arch/arm/Kconfig.debug:1445: invalid statement
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1446: invalid statement
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1447: invalid statement
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1448: invalid statement
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1449: invalid statement
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1450: invalid statement
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1451: invalid statement
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1452: invalid statement
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1453: invalid statement
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1454: invalid statement
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455:warning: ignoring unsupported character '|'
   arch/arm/Kconfig.debug:1455: invalid statement
   arch/arm/Kconfig.debug:1456: invalid statement
>> arch/arm/Kconfig.debug:1457: unexpected option "default"
   arch/arm/Kconfig.debug:1458: invalid statement
   arch/arm/Kconfig.debug:1459: invalid statement
   arch/arm/Kconfig.debug:1460:warning: ignoring unsupported character '.'
   arch/arm/Kconfig.debug:1460: invalid statement
>> lib/Kconfig.debug:2049: unexpected end statement
   make[2]: *** [olddefconfig] Error 1
   make[1]: *** [olddefconfig] Error 2
   make: *** [sub-make] Error 2

vim +1445 arch/arm/Kconfig.debug

  1417	
  1418	config DEBUG_AT91_UART
  1419		bool
  1420		depends on ARCH_AT91
  1421	
  1422	config DEBUG_EXYNOS_UART
  1423		bool
  1424	
  1425	config DEBUG_S3C2410_UART
  1426		bool
  1427		select DEBUG_S3C24XX_UART
  1428	
  1429	config DEBUG_S3C24XX_UART
  1430		bool
  1431	
  1432	config DEBUG_S3C64XX_UART
  1433		bool
  1434	
  1435	config DEBUG_S5PV210_UART
  1436		bool
  1437	
  1438	config DEBUG_OMAP2PLUS_UART
  1439		bool
  1440		depends on ARCH_OMAP2PLUS
  1441	
  1442	config DEBUG_IMX_UART_PORT
  1443		int "i.MX Debug UART Port Selection"
> 1444		depends on DEBUG_IMX1_UART ||
> 1445			   DEBUG_IMX25_UART ||
  1446			   DEBUG_IMX21_IMX27_UART ||
  1447			   DEBUG_IMX31_UART ||
  1448			   DEBUG_IMX35_UART ||
  1449			   DEBUG_IMX50_UART ||
  1450			   DEBUG_IMX51_UART ||
  1451			   DEBUG_IMX53_UART ||
  1452			   DEBUG_IMX6Q_UART ||
> 1453			   DEBUG_IMX6SL_UART ||
  1454			   DEBUG_IMX6SX_UART ||
  1455			   DEBUG_IMX6UL_UART ||
  1456			   DEBUG_IMX7D_UART
> 1457		default 1
  1458		help
  1459		  Choose UART port on which kernel low-level debug messages
  1460		  should be output.
  1461	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
