From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Thu, 3 Sep 2009 15:48:52 +0200
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <200909021045.07505.sleep_walker@suse.cz>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<f17812d70909012328y78176439kd0b6f139020e9e5d@mail.gmail.com>
	<200909021045.07505.sleep_walker@suse.cz>
Message-ID: <200909031548.52461.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I discussed it with Marex after his kind review and I just set pxafb_lcd_power property according to GPIO initialization success.

Best regards,

Tomas Cech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Treo680-move-LCD-power-GPIO-to-proper-place.patch
Type: text/x-patch
Size: 2488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090903/0ceebf05/attachment.bin>
