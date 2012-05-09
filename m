From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 May 2012 10:13:11 -0700
Subject: [PATCH v2 0/3] ARM: OMAP4: register V1V8, V2V1 regulators
In-Reply-To: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
References: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120509171310.GP5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120509 00:37]:
> Hello,
> 
> Changes since v1:
> - rebased on 3.4-rc6
> 
> Original intro message:
> 
> This series adds common configuration for the V1V8, V2V1 regulators from
> twl6030. These regulators are commonly used to feed the twl6040 audio IC on
> OMAP4 based boards (SDP4430, PandaBoards).
> 
> The regulator support for the twl6040 MFD driver will be going via MFD tree to
> avoid cross tree issues.

Thanks applying into board branch.

Tony
