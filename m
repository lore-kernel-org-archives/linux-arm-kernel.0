From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 4 Dec 2015 11:38:38 +0800
Subject: [PATCH v3 0/2] arm64: stop using kstop_machine for ftrace
Message-ID: <1449200320-24854-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Based on the comments from Will and Steve,
1. Modify the commit message
2. Fix the misleading comments for ftrace_modify_code

v3:
Modify the comments again based on the comment from Steve.

Link: https://lkml.org/lkml/2015/12/3/422

Li Bin (2):
  arm64: ftrace: stop using kstop_machine to enable/disable tracing
  arm64: ftrace: fix the comments for ftrace_modify_code

 arch/arm64/kernel/ftrace.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)
