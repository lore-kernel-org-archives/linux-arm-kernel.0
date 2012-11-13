From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Nov 2012 20:08:45 +1100
Subject: linux-next: manual merge of the arm-soc tree with the net-next
 tree
In-Reply-To: <CAGhQ9Vx3Y3j0qqkEif09HebFyR+1UYmSbp=3jwuXnoiuWBdymQ@mail.gmail.com>
References: <20121113151536.50d0292e8cb88b10686b576e@canb.auug.org.au>
 <CAGhQ9Vx3Y3j0qqkEif09HebFyR+1UYmSbp=3jwuXnoiuWBdymQ@mail.gmail.com>
Message-ID: <20121113200845.719276a14b4aa37a3dbdd896@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On Tue, 13 Nov 2012 08:21:26 +0100 Joachim  Eastwood <manabian@gmail.com> wrote:
>
> The platform_data/atmel.h include shouldn't be necessary since the
> driver already includes platform_data/macb.h.
> 
> Otherwise the fix up looks correct.

Thanks, I have fixed up my fix for tomorrow.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/07aaa4ef/attachment.sig>
