From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 10 Feb 2012 11:43:58 -0800
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
References: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20120210194358.GA5537@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 11:22:20AM -0800, Lee Jones wrote:
> This patch-set satisfies 4 objectives:
>  1. Ensures each platform device can specify a suitable parent
>  2. Provides a bus for SoC devices as a means to export information
>  3. Allows ux500 to make use of the new SoC bus
>  4. Cleans up unnecessary complexity from ux500 code

I've applied the driver-core bits, nice job in sticking with this.  I'll
let the other bits trickle through the arch-specific trees.

thanks,

greg k-h
