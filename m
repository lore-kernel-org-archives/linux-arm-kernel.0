From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Mar 2012 10:06:25 +1100
Subject: linux-next: manual merge of the cpuidle-cons tree with the
 arm-soc tree
In-Reply-To: <CAMXH7KH_vgri3EPRvkXR+LddRUc=0ve=4u7yr51utBfgV5bF3w@mail.gmail.com>
References: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
 <4F5E1ECC.1040605@atmel.com>
 <CAMXH7KH_vgri3EPRvkXR+LddRUc=0ve=4u7yr51utBfgV5bF3w@mail.gmail.com>
Message-ID: <20120313100625.b500f0efb546a9f4ceeb12ba@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, 12 Mar 2012 12:03:48 -0500 Rob Lee <rob.lee@linaro.org> wrote:
>
> On Mon, Mar 12, 2012 at 11:05 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On 03/09/2012 08:37 AM, Stephen Rothwell :
> >>
> >> Today's linux-next merge of the cpuidle-cons tree got a conflict
> >> in arch/arm/mach-at91/cpuidle.c between commit 00482a4078f4 ("ARM:
> >> at91: implement the standby function for pm/cpuidle") from the
> >> arm-soc tree and commit 7a1f6e72dce1 ("ARM: at91: Consolidate time
> >> keeping and irq enable") from the cpuidle-cons tree.
> >>
> >> I fixed it up (I think - see below) and can carry the fix as
> >> necessary.
> >
> > Yes: resolution correct. Please carry it.
> 
> Who should carry this fixup and related necessary at91 changes?  Me?
> FYI, my at91 changes are dependent on my core cpuidle change, but my
> core cpuidle changes do not require any at91 changes as the at91 and
> other platform changes were only made to consolidate duplicate code.

I will carry the fixup and Linus will presumably do the same fix when he
merges these trees in his tree.  I am not sure what you mean by "related
at91 changes".

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120313/89c5e509/attachment.sig>
