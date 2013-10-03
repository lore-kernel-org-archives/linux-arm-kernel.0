From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 3 Oct 2013 13:48:05 -0700
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20131003204805.GA21187@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 03:51:25PM -0300, Fabio Estevam wrote:
> This is based on the initial work done by Sascha Hauer and Tony Prisk.
> 
> Tested on imx6q-wandboard and imx6q-sabresd boards.

Why is _any_ new work going on here instead of working to get this code
out of staging?

I really don't want to accept this at all, as I'm not seeing any effort
to get this out of staging and into the proper place in the drm tree,
sorry.

And I shouldn't have to be saying this at all, you all know better than
to try to add new hardware support for staging drivers...

greg k-h
