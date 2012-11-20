From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 20 Nov 2012 01:22:16 -0800
Subject: [RFC/PATCH 0/3] CLK: add more devm_* APIs
Message-ID: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When looking at recent driver conversions to managed resources (devm_*) there
is no devm_clk_prepare() and similar functions, which forces mixing of 2
resource management styles (managed/classic) in the same driver, which is not
great.

This patch series adds more devm_* managed APIs to the CLK subsystem so that
driver conversions can be "pure".

Not tested as I do not have relevant hardware, so testing is appreciated.

Thanks!

-- 
Dmitry
