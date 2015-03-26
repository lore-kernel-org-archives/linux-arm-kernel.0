From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 26 Mar 2015 22:30:14 +0100
Subject: [PATCH v3 0/*] serial/amba-pl011: Activate TX IRQ passively
In-Reply-To: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
References: <1427307746-2811-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150326213014.GA21687@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 06:22:26PM +0000, Dave Martin wrote:
> Thanks to Jakub Kici?ski for his bug report and discussion, and for
> showing out how we can manage without the softirq (and providing a
> patch, though merging my rework with it got difficult, so I don't
> include it in the series now).
> 
> 
> There are two alternate versions of the series threaded from this cover
> letter:
> 
>  * [PATCH v3] - patch against v4.0-rc5 that supersedes the previous
>         series; this is the less churny option.
> 
>  * [PATCH v3, tty-next..] - patches against tty-next that
>         modify/partially revert the previous series without needing a
>         rebase.
> 
> Take your pick.

I have no idea what you want me to do here, sorry.

I need to apply patches to tty-next, I can't do anything against a
"clean" 4.0-rc5 as your patches are already in tty-next.

And I can't tell the two series apart here...

Can you just resend what you want me to apply to tty-next and we can go
from there?

confused,

greg k-h
