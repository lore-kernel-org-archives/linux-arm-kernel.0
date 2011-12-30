From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Dec 2011 10:48:50 +0000
Subject: [PATCH 1/1] regulator/fixed: set constraints.apply_uV to 0
In-Reply-To: <20111230103830.GD2414@b20223-02.ap.freescale.net>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <20111230103026.GA2766@opensource.wolfsonmicro.com>
 <20111230103830.GD2414@b20223-02.ap.freescale.net>
Message-ID: <20111230104850.GE2766@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 06:38:31PM +0800, Richard Zhao wrote:

> So what's your suggestion of the issue? Below fixed regulator failed
> to register.

It shouldn't actually be passing on the constraint setting the voltage
when it constructs the constraints.
