From: vinayakpane@csu.fullerton.edu (Vinayak Pane)
Date: Tue, 1 Jun 2010 13:27:42 -0400
Subject: Preload engine in ARMv7 (cortex A8)
Message-ID: <AANLkTilGu3OC_tth-Wurgu1jcm5zKKntINGc-A8CwkxI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Reader,

I am planning to utilize the PreLoad Engine for L2 cache. In past, I have
played with cache locking with line by line in ARM9. There I could recall
that tags and indexes are generated on basis of physical address of the
data. Now in case of PLE we have the start address and number of lines to
fill with. Does the PLE operation will leave some indexes empty ? Or does
the PLE populate all the lines in that way with the source data address ? Do
I need to start PLE for the block of size equal to that of way-size ? To
ensure no lines remain empty  and to ensure no line gets overwriten by other
line.

Appreciate your comments.

Thanks
vinayak
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100601/42348758/attachment-0001.htm>
