From: yad.naveen@gmail.com (naveen yadav)
Date: Thu, 30 Dec 2010 19:40:16 +0530
Subject: Issue in kswapd daemon initilisation
Message-ID: <AANLkTinNJEgFMcqb+HEhmOkjHPdFqaVLd3yBbeJKvgfJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

when I run cat /proc/zoneinfo on my ARM target. i got two nodes.
Node 0, zone   Normal
  pages free     39642
        min      338
        low      422
        high     507
        scanned  0 (aa: 0 ia: 0 af: 0 if: 0)
        spanned  43520
        present  43180
Node 1, zone   Normal
  pages free     21822
        min      170
        low      212
        high     255
        scanned  0 (aa: 0 ia: 0 af: 0 if: 0)
        spanned  22016
        present  21844

But when I check PS, I found that
root         0 SW<  [kswapd0] is running, So here is my question .

1. why there is no kswapd demon for another node.?
If I need to enable, how can I do.
2. I check on config option ARCH_POPULATES_NODE_MAP option is disable in ARM.

Thanks
