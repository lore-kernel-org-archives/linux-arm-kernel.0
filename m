From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 11 Dec 2013 02:32:45 +0400
Subject: [PATCH 0/2] pcmcia: small fixes for sa1111 machine code
In-Reply-To: <CALT56yNxSvUTszQP+DrkG-qRZ6S7vMzqgfFqAuKH_TQORNbExA@mail.gmail.com>
References: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
 <CALT56yNxSvUTszQP+DrkG-qRZ6S7vMzqgfFqAuKH_TQORNbExA@mail.gmail.com>
Message-ID: <CALT56yN7rxbh3JfojxHYtsK_O9Ow1vqGRXBeFPSWVbvHE0zE4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Thu, Nov 28, 2013 at 5:03 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Thu, Nov 21, 2013 at 2:48 AM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> Dmitry Eremin-Solenikov (2):
>>       pcmcia: sa1111: pass sa1111_dev to badge4-specific code
>>       pcmcia: sa1111: pass sa1111_dev to jornada720-specific code
>>
>>  drivers/pcmcia/sa1111_badge4.c     | 2 +-
>>  drivers/pcmcia/sa1111_generic.c    | 4 ++--
>>  drivers/pcmcia/sa1111_generic.h    | 4 ++--
>>  drivers/pcmcia/sa1111_jornada720.c | 3 ++-
>>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> These changes do not cause any functional change, are rather trivial
> and fix few compiler warnings.
> Can we get them in?

Re-ping. These two patches are trivial, provide no functional changes,
fix few warnings.
Russell, would it be OK to merge them through your tree/patch-tracker?
Should they be merged through some other tree (if so, can you please
bless them?)

-- 
With best wishes
Dmitry
