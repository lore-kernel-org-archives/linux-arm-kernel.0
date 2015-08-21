From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Aug 2015 09:10:15 -0700
Subject: [GIT PULL] Xilinx Zynq DT changes for v4.3 v2
In-Reply-To: <55D6C6D9.3070401@monstr.eu>
References: <55D4646F.7010404@monstr.eu> <20150821020322.GO4865@localhost>
 <55D6C6D9.3070401@monstr.eu>
Message-ID: <20150821161015.GA14452@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 08:36:09AM +0200, Michal Simek wrote:
> On 08/21/2015 04:03 AM, Olof Johansson wrote:
> > On Wed, Aug 19, 2015 at 01:11:43PM +0200, Michal Simek wrote:
> >> Hi guys,
> >>
> >> Philipp just sent his PR to you with adding reset controller for Zynq
> >> (http://www.spinics.net/lists/arm-kernel/msg440136.html).
> >> Can you please consider to add this one more patch to your tree?
> >> It is one more patch on the top of existing zynq/dt branch which you
> >> already have in arm-soc git repo.
> > 
> > The change is small enough, so yes we can merge it with the below fixed:
> > 
> >> Moritz Fischer (1):
> >>       dts: zynq: Add devicetree entry for Xilinx Zynq reset controller.
> > 
> > ARM: dts: <....> is the format we want here -- that's what most other platforms
> > use as well. I.e. please add ARM as a prefix.
> 
> ok. Will keep my eye on it.
> 
> > 
> > I can do it here and just apply as a patch too instead of merging, just let me
> > know.
> 
> Yes that will be great if you can do that change on your side.

Great, patch applied to next/dt.


-Olof
