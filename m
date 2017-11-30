From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Nov 2017 14:42:10 +0100
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
Message-ID: <20171130134209.GX21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/11/2017 at 13:36:22 +0000, Patrick Br?nn wrote:
> >From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
> >Sent: Donnerstag, 30. November 2017 09:18
> >>
> >>> +/*
> >>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> >Reserved.
> >>> + */
> >>> +
> >>> +/*
> >>> + * The code contained herein is licensed under the GNU General Public
> >>> + * License. You may obtain a copy of the GNU General Public License
> >>> + * Version 2 or later at the following locations:
> >>> + *
> >>> + * http://www.opensource.org/licenses/gpl-license.html
> >>> + * http://www.gnu.org/copyleft/gpl.html
> >>> + */
> >
> >Exactly!
> >And while you are it , you could replace the boilerplate license text
> >with the SPDX id.
> >--
> 
> How would a perfect header look like?
> Looking at :
> git show b24413180f5600bcb3bb70fbed5cf186b60864bd -- drivers/
> and:
> git grep SPDX -- Documentation/
> 
> it could be:
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> or:
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> 
> Personally I would prefer:
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> 
> So, is there any guideline?
> 

I'm quoting LWN here:

"For normal C source files, the string will be a comment using the "//"
syntax; header files, instead, use traditional (/* */) comments for
reasons related to tooling."

> To be clear: I don't want to waste anyone's time on this. But as SPDX
> was intended for automation, I think it might be good to try having
> some common pattern here.
> I don't want to start a discussion, so in case there is no guideline I will
> just take the /* SPDX */ in firstline version.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
