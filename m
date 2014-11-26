From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 26 Nov 2014 13:54:33 +0100
Subject: n900: kernel cmdline from bootloader in DT mode
Message-ID: <201411261354.33652@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

for some unknown reasons when I compile kernel for n900 in DT 
mode it ignore cmdline passed by bootloader. When I comment

CONFIG_ARM_APPENDED_DTB=y

then it boots into legacy board mode and cmdline is used from 
bootloader.

When is problem?

In defconfig I have:

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
CONFIG_CMDLINE="...."
CONFIG_CMDLINE_FROM_BOOTLOADER=y

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/7b5ed020/attachment.sig>
