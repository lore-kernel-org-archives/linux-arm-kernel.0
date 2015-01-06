From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 6 Jan 2015 12:15:46 +0100
Subject: [PATCH] sound: soc: atmel sam9g20_wm8731: remove useless include
In-Reply-To: <54ABB574.30602@atmel.com>
References: <1420536080-29181-1-git-send-email-alexandre.belloni@free-electrons.com>
 <54ABB574.30602@atmel.com>
Message-ID: <20150106111546.GN4194@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bo,

On 06/01/2015 at 18:14:12 +0800, Bo Shen wrote :
> >
> >  #include <asm/mach-types.h>
> 
> Btw, do you consider to remove this also?
> 

I just sent a patch for that. Feel free to squash both.

> >-#include <mach/hardware.h>
> >
> >  #include "../codecs/wm8731.h"
> >  #include "atmel-pcm.h"
> >

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
