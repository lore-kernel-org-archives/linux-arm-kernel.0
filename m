From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 22 Dec 2010 17:31:25 -0800
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTimirgsuoM2che_ocrkvCZqGu6xEJjrjdmt9-69p@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20101223001012.GF29368@n2100.arm.linux.org.uk>
	<AANLkTimirgsuoM2che_ocrkvCZqGu6xEJjrjdmt9-69p@mail.gmail.com>
Message-ID: <AANLkTikP+JZkN7AjqaNfHY8jZ7bVsV-af=YR=MTdfnNU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 5:11 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Drivers that do not
> want to meet the constraints expected by the opportunistic offload
> clients should do what ste_dma40 does and add "depends on !(NET_DMA ||
> ASYNC_TX_DMA)"

Sorry I was looking at a local change it does not do this today, but I
recommended it to workaround the broken >64k transfer support that was
reported recently.

--
Dan
