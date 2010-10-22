From: simon@sequanux.org (Simon Guinot)
Date: Fri, 22 Oct 2010 08:27:12 +0000
Subject: [PATCH 2/2] [ARM] Kirkwood: add fan support for Network Space
	Max v2
In-Reply-To: <alpine.LFD.2.00.1010212202400.2764@xanadu.home>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287330612-11256-2-git-send-email-simon@sequanux.org>
	<1287712396.9690.378.camel@groeck-laptop>
	<alpine.LFD.2.00.1010212202400.2764@xanadu.home>
Message-ID: <20101022082712.GU29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Thu, Oct 21, 2010 at 10:08:01PM -0400, Nicolas Pitre wrote:
> On Thu, 21 Oct 2010, Guenter Roeck wrote:
> 
> > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > > From: Simon Guinot <sguinot@lacie.com>
> > > 
> > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > 
> > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > I assume this will get pushed through the ARM tree, right ?
> 
> Might be simpler if this is routed along the same path as the core code 
> it relies upon to avoid dependency ordering issues.  There is nothing 
> particularly ARM specific here anyway.

There is some changes, related to the netspace_v2-setup.c file, stagged
in your Orion tree. At some point, a merge will be needed.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101022/0fa7f33d/attachment-0001.sig>
