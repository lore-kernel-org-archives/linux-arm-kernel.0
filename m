From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 May 2014 14:49:15 +0100
Subject: [RFC PATCH 11/11] ARM: moving support for etb/etm to the
 "drivers" directory
In-Reply-To: <1401457391-12242-12-git-send-email-mathieu.poirier@linaro.org>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
 <1401457391-12242-12-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140530134915.GP3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 07:43:11AM -0600, mathieu.poirier at linaro.org wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Removing minimal support for etb/etm to favour an implentation
> that is more flexible, extensible and capable of handling more
> platforms.
> 
> Also removing the only client of the old driver.  That code can
> easily be replaced by entries for etb/etm in the device tree.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

You say "moving" in the subject, but you are *re*moving it.  This is
misleading.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
