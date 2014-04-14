From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 13:23:29 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <534BBDAC.2010801@gmail.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBDAC.2010801@gmail.com>
Message-ID: <20140414132329.48df793e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Mon, 14 Apr 2014 12:51:24 +0200, Sebastian Hesselbarth wrote:

> >   		internal-regs {
> > +			pinctrl at 10000 {
> 
> Use node label reference:
> 
> &pinctrl {
> 	...
> };

I personally dislike using node label references. I know they are used
for Ethernet because it has been done by someone else for Orion
platforms. But on all Armada 370/XP platforms, we don't use node label
references, and I'd prefer to do it the same way for Orion5x platforms
if possible.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
