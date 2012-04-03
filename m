From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 3 Apr 2012 16:29:40 -0300
Subject: [PATCH 3/3] ARM: mx28evk: Add SPI NOR flash support
In-Reply-To: <20120403192653.GA2201@pengutronix.de>
References: <1333480807-10480-1-git-send-email-festevam@gmail.com>
 <1333480807-10480-3-git-send-email-festevam@gmail.com>
 <20120403192653.GA2201@pengutronix.de>
Message-ID: <CAOMZO5Dnw0+1GCnS_RgGRr3Ouf51uX=2pBi=w9Qw1OiK695b-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Apr 3, 2012 at 4:26 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> However, I think this patch should include registering the spi-device as well?

It does register it by doing: mx28_add_mxs_spi(2);

Regards,

Fabio Estevam
