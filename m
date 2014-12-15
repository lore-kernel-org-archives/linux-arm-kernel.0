From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 15 Dec 2014 17:27:18 +0100
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <20141215160752.GE967@titan.lakedaemon.net>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
 <20141215160752.GE967@titan.lakedaemon.net>
Message-ID: <548F0BE6.8070600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 15/12/2014 17:07, Jason Cooper wrote:
> Gregory,
> 
> Good to see this finally being addressed.  One not-so-minor issue below.
> 
> On Mon, Dec 15, 2014 at 04:38:08PM +0100, Gregory CLEMENT wrote:
>> Hello,
>>
>> You've been Cc'd on a relicensing patch, because at some point you
>> contributed a patch to an mvebu device tree.
>>
>> We're currently moving toward a GPL/X11 dual-license, instead of a GPL
>> license like what was done when you submitted your patches.
> 
> I like the X11 license, much more liberal than the BSD I had been
> thinking of.
> 
> What were the reasons for changing GPLv2 -> GPLv2+?  Why not preserve
> the author's intent re GPL and do:
> 
> 	GPLv2  -> GPLv2/X11
> 	GPLv2+ -> GPLv2+/X11

I thought about it bu I finally chose to switch to GPLv2+ for severals reason:

- as the intent of this relicensing was to allow to use the dts in more project,
  switching from GPLv2 to GPLv2+ seemed to me the things to do.

- the allwiners device tree switched to GPLv2+/X11 I followed this for consistency.

- for the same reason I chose to have the same license for all the files.

- for those how are reluctant to the GPLv3, I thought that the fact the files were
  also licensed under the X11 license minimized the impact of the GPLv3.

- last reason, I thought it would be easier to automatize this.

Now if one of the author is opposed to this change, I have no problem to keep the GPLv2
on the problematic file(s).


Thanks,

Gregory


> 
> Please note: I have no interest is a flame war re GPLv2/GPLv3.  No ones
> minds are going to be changed at this point.  I'm simply looking to stay
> closer to the author's intentions and extend the usefulness of the DT
> tree.
> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
