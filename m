From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Apr 2013 18:46:02 +0100
Subject: [PATCH v2] ARM: Kconfig: let ARM9TDMI and ARM7TDMI invisible.
In-Reply-To: <51775D88.2000406@asianux.com>
References: <51775BB3.6000607@asianux.com> <51775D88.2000406@asianux.com>
Message-ID: <20130424174602.GA14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:20:24PM +0800, Chen Gang wrote:
> If CONFIG_MMU is disabled, it will let ARM9TDMI and ARM7TDMI visible,
> but in fact, only AT91X40 need ARM7TDMI, so need not let them visible.

I'll apply it myself this evening.  Can I add:

Tested-by: Chen Gang <gang.chen@asianux.com>

to it?
