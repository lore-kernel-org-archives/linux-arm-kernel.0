From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 12 Mar 2015 04:05:43 -0700
Subject: [PATCH v8 2/4] hwspinlock/core: add device tree support
In-Reply-To: <1425520876-37826-3-git-send-email-s-anna@ti.com>
References: <1425520876-37826-1-git-send-email-s-anna@ti.com>
 <1425520876-37826-3-git-send-email-s-anna@ti.com>
Message-ID: <20150312110543.GT26334@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 04 Mar 18:01 PST 2015, Suman Anna wrote:

> This patch adds a new OF-friendly API of_hwspin_lock_get_id()
> for hwspinlock clients to use/request locks from a hwspinlock
> device instantiated through a device-tree blob. This new API
> can be used by hwspinlock clients to get the id for a specific
> lock using the phandle + args specifier, so that it can be
> requested using the available hwspin_lock_request_specific()
> API.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
