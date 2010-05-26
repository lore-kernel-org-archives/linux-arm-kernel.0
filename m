From: fachkar.datawind@gmail.com (f. achkar)
Date: Wed, 26 May 2010 17:11:22 -0400
Subject: defining ARM machine type properly
Message-ID: <4BFD8E7A.6050103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,
I'm trying to port smdk2450 arch to the a new kernel 2.6.32-9, I did the
initial work as per various googled documents, but somehow the current
initial Image is failing at arch/arm/kernel/head-common.S :
'__lookup_processor_type', and eventually goes to '__error_a' of the
same file! this seems to be related to the definition of machine_type as
defined in :
include/asm-arm/mach-types.h  and arch/arm/tools/mach-types*
I checked where the definition goes in  include/asm-arm/mach-types.h by
inserting
#error 2223XX
into various parts of that header and seems fine at the point.
nevertheless I'm not 100 sure
I wonder if the is a definitive reference to guide in this matter,
better yet a check-list like procedure??
thanks,
ferar
