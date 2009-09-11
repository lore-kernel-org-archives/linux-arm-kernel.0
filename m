From: sleep_walker@suse.cz (=?UTF-8?q?Tom=C3=A1=C5=A1=20=C4=8Cech?=)
Date: Fri, 11 Sep 2009 13:57:00 +0200
Subject: generalise Treo680 code and add support for Palm Centro - round 3
Message-ID: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is round 3 of generalisation Treo680 code and consequential add Palm Centro 685 support.

Changes since last round:
	- filename is now palmtreo.c to remain Palm devices consistency
	- generic functions are now beginning with treo_ (instead of previous palmgsm_)
	- pxamci_platform_data now contains also '.gpio_card_ro		= -1,'
	- added MAINTAINERS entry
	- reduced patchset (patches preceding these are already applied)

Thanks for your time.

Round 3 - fight!

Best regards,

Tomas Cech
