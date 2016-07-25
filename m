From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Jul 2016 15:50:50 +0200
Subject: [PATCH 14/18] ARM: mvebu: add support for the Armada 395 SoC
 family
In-Reply-To: <CAL_JsqJeObuS8OWeErRA5MX-SrMtu_254A-LtP9-A=xdPO7p1Q@mail.gmail.com>
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-16-git-send-email-jaz@semihalf.com>
 <20160721221605.GA21883@rob-hp-laptop>
 <CAH76GKOidxFZ7R1pQZ2W9BRBCxEnLXNHQGrXbAUmouozBUj51Q@mail.gmail.com>
 <CAL_JsqJeObuS8OWeErRA5MX-SrMtu_254A-LtP9-A=xdPO7p1Q@mail.gmail.com>
Message-ID: <20160725155050.3aee974e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 25 Jul 2016 08:47:23 -0500, Rob Herring wrote:

> > I am not sure if I get your point. The Armada-398 extends the
> > Armada-395 about 2 additional SATA ports (as you can see in commit
> > "[PATCH 15/18] ARM: mvebu: a398: update the dtsi about missing
> > interfaces"). In this example the a398-db board contains the Armada398
> > SoC, so it is a better match and goes first.  
> 
> But your patch title is adding 395 support, but you are adding the
> string to a 398 based board. It would make sense to have 395 here if
> the OS already had support for 395 and you want to support the 398
> without updating the OS. That doesn't seem to apply here.

I think the argument of Grzegorz is that the 398 is functionally a
strict superset of the 395, so that anything that applies to the 395
will also apply to 398.

Now, whether it is a good idea to consider them "compatible" in the DT
sense, I'm not sure.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
