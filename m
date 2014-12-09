From: wangnan0@huawei.com (Wang Nan)
Date: Tue, 9 Dec 2014 10:14:10 +0800
Subject: [RESEND][PATCH v15 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: 1418047765-53197-8-git-send-email-wangnan0@huawei.com
Message-ID: <54865AF2.5040707@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like v15 patch solves the problems found in patch v13 and v14. I run Tixy's test
cases in a loop for a whole night on two real unpublished Hisilicon ARM A15 SoCs (I
backported kprobes to 3.10 kernel), no problem arise, they are still running now.
