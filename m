From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 29 Oct 2017 21:34:00 +0100
Subject: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
In-Reply-To: <20171029175257.dfmf5642zfszoxe3@ninjato> (Wolfram Sang's message
 of "Sun, 29 Oct 2017 18:52:57 +0100")
References: <20170814164303.2383-1-wsa@the-dreams.de>
 <87d15qlq6z.fsf@belgarion.home>
 <20171029175257.dfmf5642zfszoxe3@ninjato>
Message-ID: <87y3ntlmmf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

Hi Wolfram,

> Wouldn't it be even cleaner if patch 1 & 2 above would be swapped? First
> move the chunk, then rename the file?
Yeah sure.

> And is there a branch I should base this on? Currently, I am thinking of
> basing this patch on for-next and then submit it around rc1 time.
>
> Does that make sense to you?
Yeah that's good. I usually make my pull requests around -rc5, that gives enough
time to review and test on my side.

As for the base, for-next is exactly pxa/for-next as no patches are pending, so
go ahead and base your work on it please.

Cheers.

-- 
Robert
