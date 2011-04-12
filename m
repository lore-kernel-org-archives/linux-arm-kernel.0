From: pwaechtler@mac.com (Peter =?iso-8859-1?q?W=E4chtler?=)
Date: Tue, 12 Apr 2011 20:52:17 +0200
Subject: since when does ARM map the kernel memory in sections?
Message-ID: <201104122052.17453.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linux ARM developers,

did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
Or was the memory always mapped in sections?

I still have to chase a potential memory corruption. The rootfs is located on 
a SDcard and gets corrupted even when the filesystem test programs write to 
different partitions.
The test scenario includes several dozen or even hundreds of warm and cold 
boot sequences, file system write tests with sudden soft resets. It's a large 
embedded project with a lot of drivers and the fact that always the rootfs and 
often the superblock gets damaged let me think of a memory corruption.

  Peter
