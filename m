From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 02 May 2013 12:31:05 -0600
Subject: [RFC PATCH v2 13/13] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <1366644455-16550-14-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-14-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5182B0E9.3090006@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2013 09:27 AM, Lorenzo Pieralisi wrote:
> In order to extend the current cpu nodes bindings to newer CPUs
> inclusive of AArch64 and to update support for older ARM CPUs this
> patch updates device tree documentation for the cpu nodes bindings.

Since I'm late reviewing this due to vacation, I imagine this has been
applied by now. But for the record, the structure of the DT binding
documentation in this version does look much better to me, and addresses
any concerns I had with v1.
