From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Sun, 10 Feb 2013 14:57:26 +0000
Subject: [FIX v2] v3.8-rc: fix for MM ASID code in BE mode
Message-ID: <1360508248-25252-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a pair of patches to fix the ASID allocation in BE mode, and
probably should be merged as soon as possible.

This is a n

Also available at:

 git://git.baserock.org/delta/linux baserock/bjdooks/arm-fix-asid

 [PATCH 1/2] ARM: mm: replace direct access to mm->context.id with
 [PATCH 2/2] ARM: mm: mm->context.id fix for big-endian
