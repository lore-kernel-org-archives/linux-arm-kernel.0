From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Jun 2014 09:15:26 -0400
Subject: [PATCH V2 08/19] irqchip: crossbar: fix checkpatch warning
In-Reply-To: <539A9A87.6020004@ti.com>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-9-git-send-email-r.sricharan@ti.com>
 <20140612131042.GU8664@titan.lakedaemon.net>
 <5399AC9C.4080602@ti.com> <1402582711.9947.17.camel@joe-AO725>
 <20140612153226.GE8664@titan.lakedaemon.net>
 <1402589159.12385.4.camel@joe-AO725> <539A9A87.6020004@ti.com>
Message-ID: <20140613131526.GH8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 12:00:31PM +0530, Sricharan R wrote:
>   Ok, if this is not qualifying as a separate patch then i will merge
>   this with other patches in the series which touch them.

A good general rule of thumb is to just run checkpatch on the patches,
not the source files.  This way, we prevent new warnings from being
introduced, and we can cleanup stuff in the immediate vicinity to code
we are already changing.

thx,

Jason.
