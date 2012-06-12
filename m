From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 12 Jun 2012 13:45:38 +0200
Subject: [PATCH] ARM: remove linkup-l1110.h
In-Reply-To: <1339495469.30984.115.camel@x61.thuisdomein>
References: <1339495469.30984.115.camel@x61.thuisdomein>
Message-ID: <4FD72BE2.2030804@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2012 12:04 PM, Paul Bolle wrote:
> No file includes this header. Nothing seems interested in the things
> this header provides. It appears that it has never been included since
> at least v2.6.12-rc2. It can safely be removed.
>
> Signed-off-by: Paul Bolle<pebolle@tiscali.nl>
> ---
> Tested by "git grepping" the (history of) the tree for a few things.
>
>   arch/arm/include/asm/hardware/linkup-l1110.h |   48 --------------------------
>   1 files changed, 0 insertions(+), 48 deletions(-)
>   delete mode 100644 arch/arm/include/asm/hardware/linkup-l1110.h
>
These are the definitions for chip which is used on 2-slot CF/PCMCIA
extension "jackets" on iPaq h3100/h3600. Currently h3600 PCMCIA driver
doesn't support such 2-slot "jackets", so yes, this header can be removed.

You can add my
Acked-by: Dmitry Artamonow <mad_soft@inbox.ru>
if you like.

Thanks for cleaning it up!

--
Best regards,
Dmitry "MAD" Artamonow
