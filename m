From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 21 Aug 2013 02:10:09 +0000 (UTC)
Subject: [PATCH 00/12] DRA7xx PRCM, hwmod and DT data 
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1308210203190.6426@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 9 Jul 2013, Rajendra Nayak wrote:

> This series adds the data files for DRA7xx devices for
> PRCM, hwmod and DT. This is dependent on the core support [1]
> patches for DRA7xx and leaves out the clock data since its
> on its way to DT [2]
> 
> The regbit headers for prm and cm are cleaned up post the
> autogeneration as 95% was seen to be currently unused
> (prm-regbits-7xx.h was 100% unused and hence removed)
> 
> These patches along with the core support patches are available at:
> git://github.com/rrnayak/linux.git for-3.12/dra-core-data

Is a public TRM available for this chip?

Can development boards be made available to the OMAP maintainers so we can 
ensure that the code, once merged, continues to work?


- Paul
