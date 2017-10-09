From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 9 Oct 2017 13:52:39 -0400
Subject: [PATCH v4 00/26] KVM/ARM: Add support for GICv4
In-Reply-To: <20171006153401.5481-1-marc.zyngier@arm.com>
References: <20171006153401.5481-1-marc.zyngier@arm.com>
Message-ID: <20171009175239.GE23730@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 06, 2017 at 04:33:35PM +0100, Marc Zyngier wrote:
> This series implements full support for GICv4 in KVM, bringing direct
> injection of MSIs to arm and arm64, assuming you have the right
> hardware (which is quite unlikely).
> 
> To get an idea of the design, I'd recommend you start with commit
> 7954907bedaf as well as patch #26, which try to shed some light on the
> approach that I've taken. And before that, please digest some of the
> GICv3/GICv4 architecture documentation[1] (less than 800 pages!). Once
> you feel reasonably insane, you'll be in the right mood to read the

You may want to update the link:

s/pfd/pdf/

(Does that mean you typed this by hand, my gosh, you really are breathing
this everyday) :-)

> code (no, I didn't bother changing the above, I already hit LWN/QotW
> once).
