From: qiuxishi@huawei.com (Xishi Qiu)
Date: Tue, 12 Jan 2016 10:47:14 +0800
Subject: [RFC] arm64: failed when run the command: timedatectl set-timezone
 Asia/Shanghai
Message-ID: <56946932.70601@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Failed when run the command: timedatectl set-timezone Asia/Shanghai
But CONFIG_PGTABLE_LEVELS=3 is OK, and CONFIG_PGTABLE_LEVELS=4 is failed.
The kernel is v4.1, and this command need the lib polikit.

Is this the bug of kernel?

Thanks,
Xishi Qiu
