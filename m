From: sophian.yoma@gmail.com (yoma sophian)
Date: Thu, 16 Apr 2015 13:28:41 +0800
Subject: some question about writel implement in arm platform
Message-ID: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
the implementation of writel in ARM is writel_relaxed() with barrier
before (DSB + outer cache sync).

if the memory is device memory, shall we still need outer cache sync?
if the memory is normal normal, under what circumstance we will write
it with writel.
As far as I know, the writel is used for register writing.

appreciate your kind help in advance,
