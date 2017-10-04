From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Wed, 4 Oct 2017 16:25:58 +0900
Subject: defconfig'ed v4.13 does not boot on ThunderX
Message-ID: <135495b6-e13e-5c90-6130-addb60d0fa5c@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

defconfig'ed kernel v4.13 does not boot on ThunderX, leaving only
messages below:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...

Our HW is by GIGABYTE, the model is R150 T62 rev 100:

http://b2b.gigabyte.com/ARM-Server/R150-T62-rev-100#ov

The BIOS we're on is T43. Has anyone testing upstream kernels seen a 
similar
issue like this?

Itar
