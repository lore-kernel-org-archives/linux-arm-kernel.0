From: davem@davemloft.net (David Miller)
Date: Mon, 01 Aug 2016 13:44:09 -0700 (PDT)
Subject: [PATCH 1/1] net: bcm63xx: avoid possible null pointer dereference
In-Reply-To: <1469953469-20782-1-git-send-email-xypron.glpk@gmx.de>
References: <1469953469-20782-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160801.134409.1016429746416712661.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 10:24:29 +0200

> If dev_get_platdata has failed pd is null.
> Do not dereference a null pointer.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied.
