From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 19 May 2011 15:34:44 -0400 (EDT)
Subject: [PATCH 0/7] Move Qualcomm gpio drivers into drivers dir
In-Reply-To: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
References: <1305755453-31112-1-git-send-email-davidb@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1105191533250.14430@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 May 2011, David Brown wrote:

> This patch series moves the Qualcomm MSM gpio device drivers into the
> drivers/gpio directory.
> 
> The MSM's have two flavors of gpio driver.  The one for the newer
> v7-based chips is a bit cleaner, and can just be moved.  The one for
> the older v6-based chips took some cleanup to get rid of numerous
> ifdefs based on the particular machine.  Both drivers can now be
> selected and will be used on appropriate targets.
> 
> There is still a minor entanglement with the MSM-specific gpiomux
> code.  This will be cleaned up as MSM moves to use pinmux.

Looks good.

Acked-by: Nicolas Pitre <nicolas.pitre@l;inaro.org>


Nicolas
