Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ECCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:35:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABC0206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d09TAt3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABC0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w3LlJPNg43zFK5Ob+ZigMhhVFx2lC11B+YWwazcnziM=; b=d09TAt3KD/ij6Q
	KXafHwQiG0vE/pDy8nrvpHZ0iv11vsDOuEizf26KxG0DfADzzTpyQAMpaDHBFVPhtScFQnopLjN27
	rTV15JkYmZj9nqg5HNGXzwm5zM8uGJZuEQr/luSnA4TTM9BVCUC/i0MwL/yW7CrJQBeiek1Ze2Tpm
	QiOy6MnqewMBa+b899M1lLu64ysME5s0lACAxWKGwn0AuYSNKuRK/yYzyAGKECh7LLOB2pSoe34Zk
	0wXolB1UxREci4fBg8Uthq2jlpG32Qg68BOntM3IR0NOD2UMkqK0wLUPA25OHcg21lh91of1O+YKK
	X0NF381MQ2lLxwqUoIyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giP3m-0004tw-0Q; Sat, 12 Jan 2019 19:35:10 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giP3h-00041n-J4; Sat, 12 Jan 2019 19:35:07 +0000
Received: from oxbsltgw61.schlund.de ([212.227.220.199]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1aQN-1gfwDb1O2t-0038MT; Sat, 12 Jan 2019 20:34:56 +0100
Date: Sat, 12 Jan 2019 20:34:54 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Sergey Suloev <ssuloev@orpaltech.com>
Message-ID: <458895695.364954.1547321694901@email.ionos.de>
In-Reply-To: <2da60463-f536-84f4-a176-4f8df30f6eaf@orpaltech.com>
References: <1545780008-22271-1-git-send-email-stefan.wahren@i2se.com>
 <1545780008-22271-3-git-send-email-stefan.wahren@i2se.com>
 <2da60463-f536-84f4-a176-4f8df30f6eaf@orpaltech.com>
Subject: Re: [PATCH V4 2/3] ARM: dts: add Raspberry Pi 3 A+
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ZvqQIdSwdb9vAVNpFaUKRDtKj6Yo0Ha2hDrxbE7ZWiWk3HX15T0
 RFN8dsxie7PhmsiuyoLF8vEMYsnWn8aKq9+7T17b6ckTtQAvpd0u+5N5d7fsMm4pG1KxF6A
 bQCgHVwDFP4BXwa1f9upkeGze6HcBaWDgTVMrMqkZpE4uP/+4S2JlxVsdhfU9/3StkXzdED
 fmt1PwVsBkOqYDWXqKhfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lFTqK3XTlwM=:LynM176jz1CXIMGEMRTORJ
 A5D0mD7UkdKn2XdYRrcMlrOOe5iVEfLTNoXZooM00OnLpIxCBt01i3h8YzqFkhyYhPp5FNYF1
 HxEJu4WncmsGz9gtTEGbi8TYC9Z5TaWa/dFw48bAJTAyw2YfAsDeUr0R8v3tw0gltTNPhCLYN
 ZKAQlkm3fkzKcmWUhs1YIrYHatcAclEWAYMWHyS+ZbBNfqeR35Tvaw4euZJemkt/D+AukdHkl
 y17CCo9ds9cilh+3xz6C4rAXbOEGfobSN6dbDch5LyX1uh8qR2hUrzhxagywY2k2SBSjxtPpC
 ETEOIh7kZCwKhNPYARp3gw3MT5Fc1bkPOVsF7oTIb2mxwA+47X3Gl5lrCCWJUt8mvUks0KrIp
 5I4Xo3NFK7y/8WcRpOeG9MAGngP8rtZWomo5tvwLFrXfsUHOd5yVn1z0zXI4FT0pz1z8Gzd/K
 1ifWwu9ZiHyKKS1kJRyAE3cItCuMvZTE7NWLizeOJMAGFn10LNCjnyapFCottAnFRF0g0ld7A
 VWW6fhae9fGCuankhFrmhcx7QBKQmZZeFy+e2Au7VQUDXQqSHUXtUCZddO4YbkMl4XoZsKtip
 xbTauKH/n2Ij+7of01mRv6N9ubfaVDlSxJDMvywRv7rpG1dpeadvnUAfU9OmpeaLpyDj1wCNQ
 KsFngoJzw9Q70W25jw1LlWh3QM9nW3EkeXm20IIlssJp/N2lm72pKlaukVx0buVuKHKdLwjpK
 1Dz9zeLi0dZhP092CbpTP59ugV2c5PlD+5CMd4L4CCXavbrWsTs+JNnNajQ=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190112_113505_944437_5C20A448 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sergey,

> Sergey Suloev <ssuloev@orpaltech.com> hat am 12. Januar 2019 um 19:11 geschrieben:
> 
> 
> Hi, Stefan,
> 
> is this patch the only update required to run Rpi3 A+ with kernel 4.20?

this patch depends on the "Improve VCHIQ cache line size handling" series. But you could also use the RPi 3 B+ DTB.

Btw you are replying to an outdated version of this series. V5 has been applied.

Stefan

> 
> Thank you,
> Sergey

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
