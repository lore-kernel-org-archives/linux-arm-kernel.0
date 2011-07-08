From: gregkh@suse.de (Greg KH)
Date: Fri, 8 Jul 2011 07:57:25 -0700
Subject: [Qualcomm PM8921 MFD 4/6] mfd: pm8xxx-mpp: Add pm8xxx MPP driver
In-Reply-To: <1299104001-5240-5-git-send-email-adharmap@codeaurora.org>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-5-git-send-email-adharmap@codeaurora.org>
Message-ID: <20110708145725.GA2395@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 02:13:19PM -0800, adharmap at codeaurora.org wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Add support for multi-purpose pins (MPPs) on Qualcomm PM8xxx
> PMIC chips.
> 
> PM8xxx MPPs can be configured as digital or analog inputs or
> outputs, current sinks, or buffers.
> 
> Change-Id: Iab39b2f7c2ba3f35ef6ac74d37ee7add8c70681f

What is this line for?  It makes no sense for a patch that is being
submitted to the kernel tree, please remove it.

> Signed-off-by: David Collins <collinsd@codeaurora.org>

Why have you sent this patch from a different email address than this
one?

greg k-h
