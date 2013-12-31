From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 31 Dec 2013 17:20:47 +0100
Subject: [PATCH v3 0/5] input: Add new sun4i-ts driver for Allwinner sunxi
Message-ID: <1388506852-3548-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is v3 of my sun4i-ts driver for Allwinner sunxi patch-set.

Changed this version:
-Addressed review comments from Dimitri
-Addressed review comments from Guenter
-Addressed review comments from Maxime
-Initialize ignore_fifo_data to true, the very first coordinate can be
 wrong too

Thanks & Regards,

Hans
