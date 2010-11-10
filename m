From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Nov 2010 16:27:39 -0700 (MST)
Subject: [PATCH 6/6] omap:clocks44x-add dummy clock for mailbox
In-Reply-To: <1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<1289393121-7911-7-git-send-email-h-kanigeri2@ti.com>
Message-ID: <alpine.DEB.2.00.1011101626570.28301@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hari

On Wed, 10 Nov 2010, Hari Kanigeri wrote:

> In omap4, there is no explicit configuration register to enable mailbox clocks.
> Defining dummy clock for mailbox clock module to keep the mailbox driver
> backward compatible with previous omaps.

If you split this off from the rest of your series, I'll queue it for .38.


- Paul
