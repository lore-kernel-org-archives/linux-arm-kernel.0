From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Jul 2018 08:18:00 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
 (Olof Johansson's message of "Sun, 15 Jul 2018 16:50:25 -0700")
References: <20180716091337.6c1b2a4d@canb.auug.org.au>
 <CAOesGMgicOOi0Nr+m_UHEGYL+ryRW65YAPwVsN+CZpo6kc2FLA@mail.gmail.com>
Message-ID: <87601faelj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> It's a known issue due to dependencies with a driver tree. :(
>
> Robert, this is unfortunate. What's the dependent patches? We can pick
> them up in our tree as duplicates if needed.
I'd rather postpone one of the patches, as I explained in the pull request.
As Stephen noticed, this will be :
0d0b16b8e008 ("dmaengine: pxa: make the filter function internal")

I'll queue this one for the 4.20 cycle. By the way, all of this cames from the
fact that I didn't take this very patch in my imutable branch for this change
...

I'll also resend a pull request, without this patch if that's good for you,
which will solve the breakage.

Cheers.

-- 
Robert
