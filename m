From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Wed, 2 Sep 2009 10:45:07 +0200
Subject: [PATCH 2/5] Treo680: remove unused LCD power GPIO
In-Reply-To: <f17812d70909012328y78176439kd0b6f139020e9e5d@mail.gmail.com>
References: <1251739561-28972-1-git-send-email-sleep_walker@suse.cz>
	<f17812d70909012325h42a834cqad3627fb3e4fe62d@mail.gmail.com>
	<f17812d70909012328y78176439kd0b6f139020e9e5d@mail.gmail.com>
Message-ID: <200909021045.07505.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Dne St 2. z??? 2009 08:28:51 Eric Miao napsal(a):
> (sorry this might be html,send from my g1).
> currently, I dont think gpio for pxafb is necessary, request and init in
> board_init() should be just ok.

ok then. Here goes patch.

Best regards,

Tomas Cech
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Treo680-move-LCD-power-GPIO-to-proper-place.patch
Type: text/x-patch
Size: 2734 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090902/3286c3b4/attachment.bin>
