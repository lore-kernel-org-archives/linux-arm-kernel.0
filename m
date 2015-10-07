From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 7 Oct 2015 17:53:25 +0100
Subject: [PATCH 4/6] coresight: etm3x: adding cpu affinity to sysFS
 interface
In-Reply-To: <1444231603-26676-5-git-send-email-mathieu.poirier@linaro.org>
References: <1444231603-26676-1-git-send-email-mathieu.poirier@linaro.org>
 <1444231603-26676-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20151007165325.GA12439@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 09:26:41AM -0600, Mathieu Poirier wrote:
> Without access to the device tree, it is impossible to know
> what CPU a tracer is affined to.  As such adding a new sysFS
> interface to convey the information.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>


No documentation for this new attribute?
