From: jk@kimandjk.com (JK Scheinberg)
Date: Fri, 11 Feb 2011 13:22:59 -0500
Subject: DreamPlug
References: <20110211173744.GE12125@jirafa.cyrius.com>
Message-ID: <C838F4BE-BF4D-43BE-BF1C-137526C4BDC2@kimandjk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just subscribed to the list.

I received my DreamPlug a few days ago. It's up running what it came with and I'd like to help get full Squeeze running on it.

Martin sent me the following so I'm moving this discussion here.

Begin forwarded message:

> From: Martin Michlmayr <tbm@cyrius.com>
> Date: February 11, 2011 12:37:45 PM EST
> To: JK Scheinberg <jk@kimandjk.com>
> Subject: Re: dreamplug cpu
> 
> * JK Scheinberg <jk@kimandjk.com> [2011-02-11 11:47]:
>> also, i see they both have exactly the same processor or SOC if it's
>> called that.  if this is merely a repackaging then unless some of
>> the devices (enet etc) have changed won't the exact same debian
>> kirkwood dist install and work on this?
> 
> It's the same SoC, but it probably has different devices and maybe
> some of the GPIOs are different.
> 
> I don't know anything about the DreamPlug.  Do you know if technical
> specs are available online?
> 
> What needs to be done is to write a support file for the DreamPlug,
> look at sheevaplug-setup.c and guruplug-setup.c here for an example:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=arch/arm/mach-kirkwood;h=222c4a61519a225b2444678a72a6d66edbd1727a;hb=HEAD
> 
> Anyway, this should also be moved back to debian-arm so other people
> can comment.  Or even better, to linux-arm-kernel at lists.infradead.org
> (the ARM kernel list).
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/

JK Scheinberg
jk at kimandjk.com
