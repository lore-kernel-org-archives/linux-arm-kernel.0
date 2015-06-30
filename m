From: davem@davemloft.net (David Miller)
Date: Tue, 30 Jun 2015 09:37:38 -0700 (PDT)
Subject: [PATCH v4 0/3] Fix Ethernet jumbo frames support for Armada
 370 and 38x
In-Reply-To: <1435674022-13295-1-git-send-email-simon.guinot@sequanux.org>
References: <1435674022-13295-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150630.093738.48589191219422826.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <simon.guinot@sequanux.org>
Date: Tue, 30 Jun 2015 16:20:19 +0200

> This patch series fixes the Ethernet jumbo frames support for the SoCs
> Armada 370, 380 and 385. Unlike Armada XP, the Ethernet controller for
> this SoCs don't support TCP/IP checksumming with a frame size larger
> than 1600 bytes.
> 
> This patches should be applied to the -stable kernels 3.8 and onwards.

Series applied, thanks.
