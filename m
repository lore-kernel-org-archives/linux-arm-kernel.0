From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Nov 2011 14:32:08 -0700 (MST)
Subject: [PATCH] ARM: OMAP: Add support for AM35xx UART4/ttyO3
In-Reply-To: <1318963661-27755-1-git-send-email-kyle.manna@fuel7.com>
References: <1318963661-27755-1-git-send-email-kyle.manna@fuel7.com>
Message-ID: <alpine.DEB.2.00.1111241430590.6289@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2011, Kyle Manna wrote:

> Add hwmod support to enable access to UART4 of the AM35xx series of
> chips.  The UART4 device referenced from the TRM will show up as ttyO3.
> 
> This was tested on an AM3505.
> 
> Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>

Thanks, provisionally queued for 3.3.  I've got some hwmod data cleanup 
patches coming up that will require me to modify this patch slightly.  Do 
you think you could give the modified patch a quick test when I repost it?

regards,

- Paul
