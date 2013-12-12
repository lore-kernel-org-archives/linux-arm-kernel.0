From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 12 Dec 2013 09:01:18 -0800
Subject: [PATCH v2 1/9] arm: dt: zynq: Remove 'clock-ranges' from TTC nodes
In-Reply-To: <52A97979.1030205@monstr.eu>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-2-git-send-email-soren.brinkmann@xilinx.com>
 <52A97979.1030205@monstr.eu>
Message-ID: <552285d2-8d57-4509-a014-d97065232376@DB8EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Thu, Dec 12, 2013 at 09:53:13AM +0100, Michal Simek wrote:
> On 11/27/2013 02:04 AM, Soren Brinkmann wrote:
> > The bindings for the TTC changed in commit 'arm: zynq: Use standard
> > timer binding' (e932900a3279b5dbb6d8f43c7b369003620e137c). That change
> > removed possible subnodes from this driver rendering the 'clock-ranges'
> > property invalid for this node.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  arch/arm/boot/dts/zynq-7000.dtsi | 2 --
> >  1 file changed, 2 deletions(-)
> 
> I think this is completely unrelated to cpufreq and should just go
> directly via arm-soc tree.
> If yes, I will add 1/9 and 2/9 to zynq/dt branch.

I agree. This is just clean up that I found during this work. The second
patch could go in as well I think. cpufreq will need the CPU nodes
later, but I think there is no real reason to not add them now.

	S?ren
