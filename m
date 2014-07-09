From: dl9pf@gmx.de (Jan-Simon =?ISO-8859-1?Q?M=F6ller?=)
Date: Wed, 09 Jul 2014 13:24:04 +0200
Subject: [PATCH 0/6] LLVMLinux: Patches to enable the kernel to be
 compiled with clang/LLVM
In-Reply-To: <20140709095718.GD9485@arm.com>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
 <20140709095718.GD9485@arm.com>
Message-ID: <1485533.R9kdQa9l1r@aragorn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,


> BTW, have you tried building an arm64 kernel with clang?

ragarding arm64: yes, there is a test target already - see  
http://git.linuxfoundation.org/?p=llvmlinux.git;a=tree;f=targets/vexpress64

Reproduce with:
git clone http://git.linuxfoundation.org/llvmlinux.git
cd llvmlinux/targets/vexpress64
make


Best,
Jan-Simon
