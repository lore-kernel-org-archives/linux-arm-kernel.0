From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Mon, 1 Jun 2015 07:14:43 +0200
Subject: [PATCH] ARM: dts: am335x-boneblack: disable RTC-only sleep
In-Reply-To: <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
References: <1432136322-7609-1-git-send-email-robertcnelson@gmail.com>
 <CAALWOA8ReuBSMcu5EvLOrKGfFGBGWSdMhpL_uSnL4QvTC-n8zg@mail.gmail.com>
 <CAOCHtYigGmDY6c8woQxwdy9kU0J1h258jZXL7g7=VdrxKJC9cA@mail.gmail.com>
Message-ID: <CAALWOA9wyCsUQqER2Cqwru_2REpX6AeryWeoSuwZWDsdPPL+Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a version that attempts to address Tony's earlier request to
include some comments in the patch itself. Since I saw no way to
concisely summarize the issues, I included links to relevant messages
(and enough info to locate the thread again in case of link rot).

Since the patch itself contains more explanation, I made the commit
message more concise.

Apologies for the attachment (inline text would get fucked up by gmail)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-am335x-bone-enable-pmic-shutdown-controller.patch
Type: text/x-patch
Size: 2105 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/4cd12600/attachment.bin>
