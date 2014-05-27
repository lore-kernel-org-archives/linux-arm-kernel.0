From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 27 May 2014 11:27:32 +0100
Subject: Request inclusion of HYP mode cpu_resume fix into linux-next
In-Reply-To: <20140306184303.GA31279@e102568-lin.cambridge.arm.com>
References: <20140306184303.GA31279@e102568-lin.cambridge.arm.com>
Message-ID: <20140527102732.GA18476@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Mar 06, 2014 at 06:43:03PM +0000, Lorenzo Pieralisi wrote:
> Hi Stephen,
> 
> can I ask you please to include the following branch into linux-next:
> 
> git://linux-arm.org/linux-2.6-lp.git arm-kvm-cpuresume
> 
> It contains a patch touching ARM PM core code that requires wider testing
> coverage before I request a pull. It has been already publicly posted,
> reviewed and tested.

Patch now queued for mainline, please drop the branch from -next, it
will reappear soon through the ARM tree.

Thanks,
Lorenzo
