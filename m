From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 Dec 2013 19:29:24 -0500
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <1386884755-12366-1-git-send-email-balbi@ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
Message-ID: <52AA54E4.5000606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> A bare-minimum PM implementation which will
> server as building block for more complex
s/server/serve ;-)
> PM implementation in the future.
> 
> At the least will not leave clocks on unnecessarily
> when e.g.  a user write mem to /sys/power/state.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> improve error path a little bit.
> 
We will test this out. Thanks for the
patch Felipe.

Regards,
Santosh
