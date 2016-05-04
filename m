From: davem@davemloft.net (David Miller)
Date: Wed, 04 May 2016 14:02:37 -0400 (EDT)
Subject: [PATCH] drivers: net: xgene: Fix error handling
In-Reply-To: <1462284307-15401-1-git-send-email-mbrugger@suse.com>
References: <1462284307-15401-1-git-send-email-mbrugger@suse.com>
Message-ID: <20160504.140237.1301311847350900607.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <mbrugger@suse.com>
Date: Tue,  3 May 2016 16:05:07 +0200

> When probe bails out with an error, we try to unregister the
> netdev before we have even registered it. Fix the goto statements
> for that.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Applied.
