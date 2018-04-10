From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Tue, 10 Apr 2018 13:51:12 +0000
Subject: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
In-Reply-To: <20180405200916.27964-1-drivshin@awxrd.com>
References: <20180405200916.27964-1-drivshin@awxrd.com>
Message-ID: <DM5PR2101MB10326AA61D3319DBFE51CDEAFBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: 834b2964b7ab kgdb,arm: fix register dump.

The bot has also determined it's probably a bug fixing patch. (score: 97.9682)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Build OK!
v4.4.127: Build OK!

--
Thanks,
Sasha
