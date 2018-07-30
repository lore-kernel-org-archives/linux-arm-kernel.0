From: dave.kleikamp@oracle.com (Dave Kleikamp)
Date: Mon, 30 Jul 2018 10:28:18 -0500
Subject: [PATCH 0/1] arm64: for-next/core: Fix hang in machine_kexec
Message-ID: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a regression in the for-next/core branch

Dave Kleikamp (1):
  arm64: kexec: machine_kexec should call __flush_icache_range

 arch/arm64/kernel/machine_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
