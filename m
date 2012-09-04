From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 4 Sep 2012 19:24:40 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: remove unused hwmod function prototypes
In-Reply-To: <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
References: <y> <1346786149-9228-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <alpine.DEB.2.00.1209041924280.11516@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Sep 2012, Igor Grinberg wrote:

> Several hwmod function prototypes appear to not have an implementation
> because the corresponding functions were removed or renamed.
> Those prototypes are unneeded anymore - remove them.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, queued for 3.7.


- Paul
