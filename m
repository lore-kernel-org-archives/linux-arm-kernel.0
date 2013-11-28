From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 28 Nov 2013 17:03:27 +0400
Subject: [PATCH 0/2] pcmcia: small fixes for sa1111 machine code
In-Reply-To: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
References: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CALT56yNxSvUTszQP+DrkG-qRZ6S7vMzqgfFqAuKH_TQORNbExA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Nov 21, 2013 at 2:48 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Dmitry Eremin-Solenikov (2):
>       pcmcia: sa1111: pass sa1111_dev to badge4-specific code
>       pcmcia: sa1111: pass sa1111_dev to jornada720-specific code
>
>  drivers/pcmcia/sa1111_badge4.c     | 2 +-
>  drivers/pcmcia/sa1111_generic.c    | 4 ++--
>  drivers/pcmcia/sa1111_generic.h    | 4 ++--
>  drivers/pcmcia/sa1111_jornada720.c | 3 ++-
>  4 files changed, 7 insertions(+), 6 deletions(-)

These changes do not cause any functional change, are rather trivial
and fix few compiler warnings.
Can we get them in?

-- 
With best wishes
Dmitry
