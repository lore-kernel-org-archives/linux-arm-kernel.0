From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 30 May 2014 09:40:25 +1000
Subject: [PATCH] gpio: removes all usage of gpiochip_remove retval
In-Reply-To: <CABprBybQ-Jyk95zCqnoWjjyzhNyHVbsbEhb=vA5d=ZYp95_bFA@mail.gmail.com>
References: <1401400492-26175-1-git-send-email-berthe.ab@gmail.com>
 <5387B149.20408@gmail.com>
 <CABprBybQ-Jyk95zCqnoWjjyzhNyHVbsbEhb=vA5d=ZYp95_bFA@mail.gmail.com>
Message-ID: <20140530094025.3b78301e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi abdoulaye,

On Fri, 30 May 2014 01:16:22 +0200 abdoulaye berthe <berthe.ab@gmail.com> wrote:
>
> The aim of this patch is to make gpiochip_remove() behavior consistent,
> especially when issuing a remove request while the chipio chip is
> still requested. A patch has been submitted to change the return value of
> gpiochip_remove() from int to void. This one updates users of the return
> value:

Then you need to keep these two patch in a series with this one first
to make sure that the other patch is not applied without this one.

And you should add the above explanation to the changelog for this
patch.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140530/d9bb6d03/attachment.sig>
