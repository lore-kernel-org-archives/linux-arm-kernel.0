From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Jun 2013 10:55:10 -0700
Subject: [PATCH/RESEND 01/12] msm_serial: Convert to clk_prepare/unprepare
In-Reply-To: <1371490999-15501-2-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
 <1371490999-15501-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130617175510.GA15370@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:43:08AM -0700, Stephen Boyd wrote:
> Add calls to clk_prepare and unprepare so that MSM can migrate to
> the common clock framework.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or do you want me to take the serial ones through my tree?  It's your
choice, either is fine for me.

thanks,

greg k-h
