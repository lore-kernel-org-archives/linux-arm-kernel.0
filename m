From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 23 Apr 2018 13:38:28 +0200
Subject: [PATCH v2] coresight: Moving framework and drivers to SPDX
 identifier
In-Reply-To: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
References: <1523981817-16176-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180423113828.GA8720@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 10:16:57AM -0600, Mathieu Poirier wrote:
> Moving all kernel side CoreSight framework and drivers to SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
> Change for V2:
> * Added drivers/hwtracing/stm/ftrace.c as pointed out by Alex.

This doesn't apply to 4.17-rc2 :(

thanks,

greg k-h
