From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 4 Mar 2011 18:16:07 +0200
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<AANLkTi=Y-JYQ_eZ4EdNirPrm_xkiduSZP19BPWckP2iW@mail.gmail.com>
	<A6E7D305-39A1-42B3-8A2B-0D2CDBBE5EEE@prograde.net>
Message-ID: <201103041816.08109.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Michael, recently I discovered that PXA270 (at least in Zipit Z2) works 
unstable (just hangs randomly) with fastbus bit set in CCLKCFG, check if 
bootloader sets it on your board, and if it does try to clear it.

Regards
Vasily
