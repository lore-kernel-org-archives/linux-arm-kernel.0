From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Dec 2011 16:25:14 +0800
Subject: [RFC PATCH 1/8] ARM: Add commonly used cpuidle init code
In-Reply-To: <CAMXH7KHqmEB+adCB3OUSUUoYL85o_zqEv03tuxB9DEAo08KhoA@mail.gmail.com>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
 <1323146291-10676-2-git-send-email-rob.lee@linaro.org>
 <20111206114737.GF17194@sirena.org.uk>
 <CAMXH7KHqmEB+adCB3OUSUUoYL85o_zqEv03tuxB9DEAo08KhoA@mail.gmail.com>
Message-ID: <20111209082512.GI26952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 11:34:34AM -0600, Rob Lee wrote:

> I agree and had considered this as well.  Can you (or anyone else)
> suggest the best/most community friendly method of doing this?  If
> this code is moved to drivers/idle or drivers/cpuidle, then perhaps
> just making empty fiq enable/disable functions would be ok.

Sounds like a reasonable plan, or providing an arch hook mechanism as
well as a SoC hook mechanism and allowing them to use that.
