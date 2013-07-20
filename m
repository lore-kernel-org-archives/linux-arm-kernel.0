From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 20 Jul 2013 12:44:05 -0300
Subject: [RESEND PATCH v7 00/22] MBus DT binding: The return of PCIe
In-Reply-To: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373900271-4722-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130720154404.GD24504@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Arnd, Jason:

On Mon, Jul 15, 2013 at 11:57:29AM -0300, Ezequiel Garcia wrote:
> Here's the new MBus DT binding, implementing the changes proposed
> by Thomas when we discussed the previous patchset:
> 
>   http://www.spinics.net/lists/arm-kernel/msg257170.html
> 
> As far as I know, this round fixes *all* the concerns raised in the past
> and therefore I'd like to get Acked-by's from all the parties involved
> on the respective patches, and particularly for the DT binding.
> 
> If there's anything left to review, we'll be glad to fix it quickly,
> so don't hesitate in providing your feedback!
> 

Can you comment on this DT binding? Notice this is the outcome of a
lengthy discussion and has been already agreed by Arnd and Jason Gunthorpe.

If it looks OK, I'd like to have formal Acked-by's so Jason Cooper can merge it.

On the other side, given we've decided to mark some bindings as 'unstable'
or 'staging' maybe Jason can merge it so it can be in linux-next.
This way developers can actually start using this, and complaining if
there's anything to complain.

If we leave it as a patchset floating in mailing-lists it's hardly going
to get tested.

Does this approach make sense?

Thanks a lot!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
