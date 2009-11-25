From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Nov 2009 16:41:03 +0100
Subject: [PATCH V2] Add i.MX sound support
Message-ID: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Here is the second version of the patches to add i.MX sound support.

This time I haven't included ARM related patches, so this series should
be safe to apply.

I skipped the mc13783 driver since I'm not ready integrating the comments
from Mark.

The main change in the driver is that I splitted out the transport from
the driver, so it should be easy to add another transport layer to the
driver when SDMA support is merged. I hopefully also addressed the other
comments from Mark.

Sascha
