From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 12:07:43 +0200
Subject: [PATCH 20/26] ARM: pxa: select FB_PXA on saar and tevorevb
In-Reply-To: <CAMPhdO8ke1M2aFAqzfmFB-MWj6m5JsCYC_zYBC=iSX1L6kWwTw@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-21-git-send-email-arnd@arndb.de>
	<CAMPhdO8ke1M2aFAqzfmFB-MWj6m5JsCYC_zYBC=iSX1L6kWwTw@mail.gmail.com>
Message-ID: <2978851.kb50F9VMMq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 17:50:31 Eric Miao wrote:
> 
> The option really matters is FB_PXA_SMARTPANEL, which adds support
> for the display driver to control an external "smart" LCD panel. And how
> about the patch below to fix this - as normal, make empty functions
> when not enabled?
> 

Yes, your patch looks better than mine.

Thanks,

	Arnd
