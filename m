From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter?= Ujfalusi)
Date: Tue, 14 Jun 2011 15:38:41 +0300
Subject: [RFC 1/2] omap: mcbsp: Drop SPI mode support
In-Reply-To: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Message-ID: <6027329.5ZCJWRgjcM@barack>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 June 2011 13:23:51 Jarkko Nikula wrote:
> We haven't seen any use for the SPI API in McBSP driver over the years. More
> over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode is not
> even supported since OMAP2430 so it's very unlikely that we'll see any use
> for it in the future either.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Either now or later, but for both:

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
