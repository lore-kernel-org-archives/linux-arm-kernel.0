From: davem@davemloft.net (David Miller)
Date: Thu, 19 May 2016 11:25:50 -0700 (PDT)
Subject: [PATCH 1/1] net: thunderx: avoid null pointer dereference
In-Reply-To: <1463514038-9008-1-git-send-email-xypron.glpk@gmx.de>
References: <1463514038-9008-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160519.112550.1461536215214747775.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Tue, 17 May 2016 21:40:38 +0200

> In function bgx_lmac_handler only use a member of
> lmac after checking it is not null.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied.
