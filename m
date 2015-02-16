From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Feb 2015 19:03:36 +0100
Subject: [PATCH RFC 2/2] ARM: pxa: transition to dmaengine phase 1
In-Reply-To: <CA+E=qVcEfGaA=V2+cFWfEbOxxBxewfaOarw2_hGfM_4x+7M-jQ@mail.gmail.com>
 (Vasily Khoruzhick's message of "Mon, 16 Feb 2015 20:00:44 +0300")
References: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
 <1423954053-21760-3-git-send-email-robert.jarzmik@free.fr>
 <CA+E=qVfP=JY5ccUyCat5Thtk6waVng-PsnL7Y4c7_Hj+s8==nw@mail.gmail.com>
 <87wq3hajbc.fsf@free.fr>
 <CA+E=qVcEfGaA=V2+cFWfEbOxxBxewfaOarw2_hGfM_4x+7M-jQ@mail.gmail.com>
Message-ID: <87sie5ag3r.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick <anarsoul@gmail.com> writes:

> On Mon, Feb 16, 2015 at 7:54 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>> Oh, do you volunteer ? That would indeed ease up my burden. I only rebased
>> pxa3xx_nand, so any help to submit and push is welcome. At least I can commit to
>> review, and I would concentrate on pxa_camera.c in the meantime.
>
> I can rebase those patches on-top of Linus' tree and make sure they
> work on my machine.
> I can test pxamci, pxa2xx-spi and pxa2xx-pcm drivers. But I don't
> think that I have enough time now to submit it and
> go through review process.
Do your best, I'll take over when you'll meet your load limit.

> Btw, where I can find your git tree?
Here :
git fetch https://github.com/rjarzmik/linux.git work/clocks-pxa

Cheers.

-- 
Robert
