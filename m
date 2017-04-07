From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Apr 2017 12:48:46 +0200
Subject: [PATCH] pinctrl: at91-pio4: handle suspend to ram
In-Reply-To: <CACRpkdYFPhewV4NLNxxVkXCwuyoo3rgeLt0auErS47R=055FHQ@mail.gmail.com>
References: <20170406133623.19160-1-alexandre.belloni@free-electrons.com>
 <CACRpkdYFPhewV4NLNxxVkXCwuyoo3rgeLt0auErS47R=055FHQ@mail.gmail.com>
Message-ID: <20170407104846.5ghrcqc2ws4dkqxt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 at 12:16:22 +0200, Linus Walleij wrote:
> On Thu, Apr 6, 2017 at 3:36 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> 
> > When suspending to RAM, the power to the core is cut and the register
> > values are lost. Save and restore more registers than just IMR.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Should this be tagged for stable?
> 

No because that particular suspend to ram mode is not yet implemented
upstream.

> Waiting for input from the AT91 maintainers here.
> 

Well, I've been an AT91 maintainer for 2 years now and I have done all
the AT91 pull requests since 3.16. I hope this qualifies me here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
