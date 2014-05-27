From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 28 May 2014 08:45:23 +1000
Subject: Request inclusion of HYP mode cpu_resume fix into linux-next
In-Reply-To: <20140527102732.GA18476@e102568-lin.cambridge.arm.com>
References: <20140306184303.GA31279@e102568-lin.cambridge.arm.com>
 <20140527102732.GA18476@e102568-lin.cambridge.arm.com>
Message-ID: <20140528084523.534449a9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Tue, 27 May 2014 11:27:32 +0100 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Mar 06, 2014 at 06:43:03PM +0000, Lorenzo Pieralisi wrote:
> > Hi Stephen,
> > 
> > can I ask you please to include the following branch into linux-next:
> > 
> > git://linux-arm.org/linux-2.6-lp.git arm-kvm-cpuresume
> > 
> > It contains a patch touching ARM PM core code that requires wider testing
> > coverage before I request a pull. It has been already publicly posted,
> > reviewed and tested.
> 
> Patch now queued for mainline, please drop the branch from -next, it
> will reappear soon through the ARM tree.

Removed from today.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/10afaea0/attachment.sig>
