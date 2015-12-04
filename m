From: huawei.libin@huawei.com (Li Bin)
Date: Fri, 4 Dec 2015 10:18:37 +0800
Subject: [PATCH v2 0/2] arm64: stop using kstop_machine for ftrace
Message-ID: <1449195519-17901-1-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
Based on the comments from Will and Steve,
1. Modify the commit message
2. Fix the misleading comments for ftrace_modify_code

Link: https://lkml.org/lkml/2015/12/3/422

Li Bin (2):
  arm64: ftrace: stop using kstop_machine to enable/disable tracing
  arm64: ftrace: fix the comments for ftrace_modify_code

 arch/arm64/kernel/ftrace.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
