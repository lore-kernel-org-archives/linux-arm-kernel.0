From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 6 Mar 2015 18:07:08 +0100
Subject: [PATCH] pinctrl: dt: at91: new binding
In-Reply-To: <AB034DC5-9E4C-4883-BBF0-B93B438C7A54@jcrosoft.com>
References: <1424943294-8805-1-git-send-email-plagnioj@jcrosoft.com>
 <54F9C2FE.8060804@atmel.com>
 <AB034DC5-9E4C-4883-BBF0-B93B438C7A54@jcrosoft.com>
Message-ID: <20150306170708.GR3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 at 00:49:55 +0800, Jean-Christophe PLAGNIOL-VILLARD wrote :
> > 
> > Sorry but NACK.
> > 
> > I don't want to manage another flavor of the pinmux biding with no real
> > benefit. I would have been good if we had it from day-1. Now it's too late.
> 
> yes we do, we catch but a compiling time instead of RUNTIME which is critical
> 
> so I?ll pass on the NACK
> 

If you are changing the binding, how about doing it right this time and
completely drop the current mess?

> > 
> > Moreover, splitting a binding definition if you have a function given by
> > multiple banks can be weird and not well understood in regard to our
> > current group+function definition scheme (Cf. your last example).
> > 
> 
> Others already do so and this is not complex at all
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
