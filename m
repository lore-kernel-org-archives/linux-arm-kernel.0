From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Apr 2014 10:17:39 +0100
Subject: [RFC] ARM64: 4 level page table translation for 4KB pages
In-Reply-To: <000601cf4f1d$30c69400$9253bc00$%chung@samsung.com>
References: <9531814.OxBzcO1V3J@wuerfel> <20140331152719.GH29871@arm.com>
 <7050133.LRSn2ENgQ4@wuerfel> <20140401132316.GD20061@arm.com>
 <004b01cf4e27$d47da990$7d78fcb0$@samsung.com>
 <20140402090136.GA31892@arm.com> <20140402152455.GB24018@arm.com>
 <001501cf4ee2$8b639b50$a22ad1f0$%chung@samsung.com>
 <20140403083806.GA17022@arm.com>
 <000601cf4f1d$30c69400$9253bc00$%chung@samsung.com>
Message-ID: <20140403091739.GD17022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 10:14:53AM +0100, Sungjinn Chung wrote:
> On Thursday, April 03, 2014 5:38 PM, Catalin Marinas wrote:
> > On Thu, Apr 03, 2014 at 03:15:09AM +0100, Sungjinn Chung wrote:
> > > I'm worried about validation issue for 64K.
> > 
> > Why? The CPUs I'm aware of implement this feature.
> 
> Sorry for my mistake. I meant 16K so please just ignore.

A software model should help initially and probably FPGA afterwards.

-- 
Catalin
