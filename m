From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Mar 2015 11:24:11 +0000
Subject: [PATCH v10 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <20150324220253.9595AC407F8@trevor.secretlab.ca>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <20150318190509.GM10863@arm.com> <550A4BFD.4070804@huawei.com>
 <20150319101727.GC24556@red-moon> <20150319193927.GG4751@arm.com>
 <20150324220253.9595AC407F8@trevor.secretlab.ca>
Message-ID: <20150325112410.GA24636@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:02:53PM +0000, Grant Likely wrote:
> On Thu, 19 Mar 2015 19:39:27 +0000 , Will Deacon <will.deacon@arm.com>
> wrote:
> > On Thu, Mar 19, 2015 at 10:17:27AM +0000, Lorenzo Pieralisi wrote:
> > > Not only that, Sudeep has a patch to consolidate DT and ACPI SMP code,
> > > I am working on it, I do not think it should be a blocking point, patch
> > > coming asap on top of your series.
> > 
> > Well, I don't really want to merge the series without those patches so I
> > do think it blocks the code from getting into mainline.
> 
> Really? It's a pretty minor duplication problem and it's been identified
> as something requiring refactoring to both the ACPI and DT code. It
> isn't at all dangerous. Why is this a blocking point?

Because I don't really see a valid excuse not to get this right first time
around. Lorenzo already has patches on top, so we just need a co-ordinated
review effort.

I wouldn't accept another patch series that needed minor rework (which by
its very nature is easily addressed), so why should ACPI be treated any
differently?

Will
