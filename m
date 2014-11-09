From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 9 Nov 2014 09:23:11 -0800
Subject: [PATCH v8 4/8] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <CAOesGMhd37UM+7+6eR9iLY22Fb9cG1dr8dD4DAzLJNRmtysnkg@mail.gmail.com>
References: <sbranden@broadcom.com>
 <1414525992-3678-1-git-send-email-sbranden@broadcom.com>
 <1414525992-3678-5-git-send-email-sbranden@broadcom.com>
 <CAOesGMjUE-Z3L=FU1nspv5M52UhhJ9-dBLr40RTCz2WEhEPHLA@mail.gmail.com>
 <545F05F0.3000702@broadcom.com>
 <CAOesGMhd37UM+7+6eR9iLY22Fb9cG1dr8dD4DAzLJNRmtysnkg@mail.gmail.com>
Message-ID: <20141109172311.GB738@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 08, 2014 at 10:49:09PM -0800, Olof Johansson wrote:
> >>> +/*
> >>> + * Copyright 2014 Broadcom Corporation.  All rights reserved.
> >>> + *
> >>> + * Unless you and Broadcom execute a separate written software license
> >>> + * agreement governing use of this software, this software is licensed
> >>> to you
> >>> + * under the terms of the GNU General Public License as
> >>> + * published by the Free Software Foundation version 2.
> >>> + *
> >>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> >>> + * kind, whether express or implied; without even the implied warranty
> >>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + * GNU General Public License for more details.
> >>
> >>
> >> We ask for new DT contents to be added with dual BSD/GPL license, to
> >> allow for reuse of the DT data structures in other projects as well.
> >> There's currently a lot of activity going on relicensing the current
> >> files so I recommend sorting it out before they are added if you can.
> >
> >
> > This may take more time than you think.  I am going to have to go through
> > legal to get such a license created. Also, why would you need dual license?
> > If it is BSD that should serve both purposes?
> 
> I haven't followed the discussion close enough to know if there's been
> discussion about single-license BSD vs dual BSD/GPL.
> 
> At the very least, please start the process of getting it changed.
> 
> Also, I see now that this isn't even a clean GPL v2, given "Unless you
> and Broadcom..." language. I see the bnx2x driver had that in the
> past, but none of the Kona contributions did. I strongly suggest
> sticking to the normal copyrights here and not making things more
> complicated than they have to.

I'm thinking that the "unless you and Broadcom..." language really
doesn't mean much other than what all other files in the kernel mean
from what I can tell.  This should just default to GPLv2 and everyone
should be ok.

But note, I'm not a lawyer, it would be good to get a confirmation from
Broadcom that this is the exact wording they want in this file, and that
they are happy with it being "just" GPLv2 for all intensive purposes, as
it does "differ" from the wording we are "accustomed" to seeing in
kernel files.

thanks,

greg k-h
