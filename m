From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 11 Apr 2014 12:41:02 -0700
Subject: [PATCH v2 1/5] ARM: zynq: DT: Add 'clock-latency' property
In-Reply-To: <53423BB6.7010508@monstr.eu>
References: <1396653256-28397-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396653256-28397-2-git-send-email-soren.brinkmann@xilinx.com>
 <53423BB6.7010508@monstr.eu>
Message-ID: <34776df5-5255-4d58-a5ab-83f2017e16fc@AM1EHSMHS018.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 07:46AM +0200, Michal Simek wrote:
> On 04/05/2014 01:14 AM, Soren Brinkmann wrote:
> > Specify the 'clock-latency' property to avoid certain cpufreq governors
> > from refusing to work with the following error:
> >   ondemand governor failed, too long transition latency of HW, fallback to performance governor
> > 
> > Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Tested-by: Mike Looijmans <mike.looijmans@topic.nl>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> > This is a fix from our vendor tree
> > 
> > Changes in v2:
> >  - This patch has been added
> > 
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Applied to zynq-dt.

Actually, this should probably go in as fix into the current (3.15)
release cycle.

	Thanks,
	S?ren
