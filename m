From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 16 Apr 2014 21:13:10 +0400
Subject: [PATCH v4 00/21] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
References: <1387309071-22382-1-git-send-email-ynvich@gmail.com>
Message-ID: <1397668411-27162-1-git-send-email-ynvich@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

We had an intensive discussion of the series in the beginning of
December 2013 [1]. The discussion resulted in 3 versions of the series
in less than 3 weeks. Then there was a decision to block this series
until Daniel Mack's DMA-engine-for-PXA series is ready.

Unfortunately Daniel neigther agrees to review my trivial temporary
solution to the DMA-in-device-tree (patch 7 of 21), nor he is active
in DMA series development. There is no progress for 3 months.

As with any big out of tree series, its support is painful. It requires
extensive merging when doing bisects, on each step.

It would great if the decision to block could be reconsidered, and we could
move forward.

Best,

Sergei Ianovich

1. http://linux-kernel.2935.n7.nabble.com/PATCH-00-11-ARM-support-for-ICP-DAS-LP-8x4x-td761919.html
