From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Sat, 26 Feb 2011 17:42:39 +0530
Subject: [PATCH 1/1] davinci: changed SRAM allocator to shared ram.
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024BE49711@dbde02.ent.ti.com>
References: <1297434088-27995-1-git-send-email-subhasish@mistralsolutions.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024BE49175@dbde02.ent.ti.com>
	<886E26C48DE446C3937D89ECF86030B2@subhasishg>
	<B85A65D85D7EB246BE421B3FB0FBB593024BE49711@dbde02.ent.ti.com>
Message-ID: <25DBF349769A4CF7B883D6D7FF01AD70@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

I tried this using MMC and Kelvin's suggestions, but it never came back. 
Here is a log:

root at arago:~# rtcwake -d /dev/rtc0 -s 20 -m mem
wakeup from "mem" at Tue Apr 21 14:31:13 2009
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
