From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Sat, 21 May 2011 09:35:29 +0800
Subject: Updated mach-types update
In-Reply-To: <20110320110322.GC16646@n2100.arm.linux.org.uk>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=buKPmceOhF=SU6kkYRPxsJMn6hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2011 at 7:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> What this means is that any platform in the machine database which has not
> been submitted to mainline for 12 months since it was registered will be
> automatically dropped from the file, and the platform maintainer will need
> to either talk to me to get it reinstated before submission, or update the
> entry in some way to 'freshen' it.
>

Hi Russell,

Apologies, I just realized this patch removed an entry for a board I
am working with. Could you reinstate the following entry:

2363  	WAYLAND  	wayland  	Ofer Zaarur

I plan to submit support for this board as soon as I can.

Thanks,
jaya
