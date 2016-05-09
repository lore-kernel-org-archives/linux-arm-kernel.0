From: petr@barix.com (Petr Kulhavy)
Date: Mon,  9 May 2016 16:35:18 +0200
Subject: [PATCH v5 0/4] ASoC: davinci-mcbsp: add binding for McBSP
Message-ID: <1462804522-29544-1-git-send-email-petr@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds devicetree support for the davinci McBSP audio
interface.

Changes in version 5 of the patch:

* rebased to the current master of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
* independent changes submitted separately (3/7 and 7/7 of the version 4)
* 5/7 of the version 4 removed as already applied
* corrected mcbsp0 and mcbsp1 nodes in the DTS file: using correct address and sound@ prefix
