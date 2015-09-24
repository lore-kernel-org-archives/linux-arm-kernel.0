From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 24 Sep 2015 08:20:17 -0700
Subject: [PATCH v4 0/8] i.MX early debug UART clock fixes
In-Reply-To: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
References: <1442854444-4460-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20150924152016.GV3529@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 06:53:56PM +0200, Lucas Stach wrote:
> This series fixes a long standing interaction issue between the
> kernels early debug facilities and the i.MX clock drivers.

This is fixing some issue but not regression.  As the change basically
has influence on all i.MX platforms, my take is that we should get them
into linux-next for extensive testing and queue for 4.4.  Agree?

Shawn
