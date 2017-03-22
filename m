From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Mar 2017 08:16:46 +0100
Subject: [PATCH v3 01/11] ARM: sun8i: a33: add operating-points-v2
 property to all nodes
In-Reply-To: <CAGb2v65qMod+k5Uo-Z4qG=7kMx_FiHhR_01XS+Bn+m3T=JH6bg@mail.gmail.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-2-quentin.schulz@free-electrons.com>
 <CAGb2v65qMod+k5Uo-Z4qG=7kMx_FiHhR_01XS+Bn+m3T=JH6bg@mail.gmail.com>
Message-ID: <20170322071646.stljnmlnfrhpchm2@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:32:28AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > The OPP are declared as shared but no operating points are declared for
> > cpu1, 2 and 3. Thus, the following error happens during the boot:
> >
> > cpu cpu1: dev_pm_opp_of_get_sharing_cpus: Couldn't find tcpu_dev node.
> >
> > This patch applies the operating points to each cpu of the A33.
> >
> 
> This should have
> 
> Fixes: 03749eb88e63 ("ARM: dts: sun8i: add opp-v2 table for A33")
> 
> and be merged as fixes for 4.11.
> 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I just queued it as a fix for 4.11, with the fixes tag.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170322/0097ed4f/attachment-0001.sig>
