From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Thu, 3 Sep 2009 17:21:43 +0200
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <200909031548.52461.sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<200909021045.07505.sleep_walker@suse.cz>
	<200909031548.52461.sleep_walker@suse.cz>
Message-ID: <200909031721.44214.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I discussed it with Marex again after his kind review and I created some special function for it to remain machine_init function clean. I hope this one is clean enough to be accepted.

Best regards,

Tomas Cech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Treo680-move-LCD-power-GPIO-to-proper-place.patch
Type: text/x-patch
Size: 2647 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090903/f431fc0b/attachment.bin>
