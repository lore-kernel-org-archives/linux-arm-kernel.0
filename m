From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 3 May 2013 10:15:11 +0100
Subject: [RFC PATCH v2 13/13] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <5182B0E9.3090006@wwwdotorg.org>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-14-git-send-email-lorenzo.pieralisi@arm.com>
 <5182B0E9.3090006@wwwdotorg.org>
Message-ID: <20130503091510.GB20678@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 02, 2013 at 07:31:05PM +0100, Stephen Warren wrote:
> On 04/22/2013 09:27 AM, Lorenzo Pieralisi wrote:
> > In order to extend the current cpu nodes bindings to newer CPUs
> > inclusive of AArch64 and to update support for older ARM CPUs this
> > patch updates device tree documentation for the cpu nodes bindings.
> 
> Since I'm late reviewing this due to vacation, I imagine this has been
> applied by now. But for the record, the structure of the DT binding
> documentation in this version does look much better to me, and addresses
> any concerns I had with v1.

It is not merged yet, but hopefully it can be as soon as the merge
window closes, I just need to update some bits and bobs after rebasing,
to take into account changes that got merged this cycle.

I will repost a, hopefully, final series as soon as the merge window closes.

Thanks,
Lorenzo
