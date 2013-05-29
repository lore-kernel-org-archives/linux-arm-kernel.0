From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Wed, 29 May 2013 09:50:44 +0200
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
References: <51A5A808.2070803@digi.com>
 <F281D0F91ED19E4D8E63A7504E8A649803E8A3F3@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <20130529075044.GC3293@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 29, 2013 at 07:11:30AM +0000, Chen Peter-B29397 wrote:
>  
> > Hello,
> > 
> > Am I right in assuming that the MXS USB on-the-go port does not currently
> > support the
> > device (gadget) functionality?
> > Anybody out there working on that?
> > 
> 
> As far as I know, Maxime Ripard may already let the chipidea durl-role function
> work ok at mx28. It may need my chipidea otg patch
> 
> https://github.com/hzpeterchen/linux-usb.git

Indeed, I've been using the patchset "Add tested id switch and vbus
connect detect support for Chipidea" from Peter for quite some time on
top of 3.9 and it works like a charm for the gadget mode on an MX28
platform.

BTW, Peter, I've seen that these patches are still not merged in 3.10,
is there a reason for that? do you plan on sending a version rebased on
top of 3.10 some time in the future? I tried to do the rebasing myself,
but the chipidea driver seems to have changed quite heavily, which makes
the process quite difficult when you don't know what you're doing :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
