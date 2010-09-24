From: r65037@freescale.com (Richard Zhu)
Date: Fri, 24 Sep 2010 11:54:23 +0800
Subject: [4-0] serial patches that enable the eSDHC on iMX51
Message-ID: <1285300467-5158-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All:
Sorry, for wrong --compose usage.

Hi Wolfram:
Here are the patches that enable the sdhci of i.MX51.
The IO and WP funcs are verified on i.MX51 BBG board.
The misssing bits of the HOST_CONTROL and so on had been made up in the 4-3 patch.


Hi Uwe:
I would change MSL part to the "dynamically allocated method" later.

Any review/comments/suggestions are appreciated.
Thanks in advanced.
