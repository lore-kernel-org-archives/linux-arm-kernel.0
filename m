From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Apr 2013 17:40:18 +0100
Subject: [RFC v1] regulator: core: introduce regulator chain locking scheme
In-Reply-To: <516C2905.8000200@ti.com>
References: <1366031015-17073-1-git-send-email-grygorii.strashko@ti.com>
 <1366031015-17073-2-git-send-email-grygorii.strashko@ti.com>
 <20130415155040.GD15837@opensource.wolfsonmicro.com>
 <516C2905.8000200@ti.com>
Message-ID: <20130415164018.GA14064@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 07:21:25PM +0300, Andrii Tseglytskyi wrote:
> On 04/15/2013 06:50 PM, Mark Brown wrote:

> >>In addition, such locking scheme allows to have access to the supplier
> >>regulator API from inside child's (consumer) regulator API.

> >I've still not seen any use case articulated for doing this...

> Use case is introduced in ABB series:

Sorry, I meant any sensible use case.
