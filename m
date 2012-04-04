From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 4 Apr 2012 08:31:31 -0600 (MDT)
Subject: [PATCH] OMAP: HSMMC: avoid erratum workaround when transceiver
 is attached
In-Reply-To: <1331902194-4679-1-git-send-email-notasas@gmail.com>
References: <1331902194-4679-1-git-send-email-notasas@gmail.com>
Message-ID: <alpine.DEB.2.00.1204040831220.8000@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Mar 2012, Grazvydas Ignotas wrote:

> If transceiver is attached to a MMC host of ES2.1 OMAP, it seems
> 2.1.1.128 erratum doesn't apply and there is no data corruption,
> probably because of different signal timing. The workaround for this
> erratum disables multiblock reads, which causes dramatic loss of
> performance (over 75% slower), so avoid it when transceiver is present.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Thanks, queued for 3.4-rc.

- Paul
