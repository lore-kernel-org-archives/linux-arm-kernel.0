From: rubini@unipv.it (Alessandro Rubini)
Date: Fri, 5 Oct 2012 14:58:21 +0200
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
In-Reply-To: <CACRpkdYMz05DwtLtHkggvo8VFOtvPLpovwq6fLceeiFK0Wci0Q@mail.gmail.com>
References: <CACRpkdYMz05DwtLtHkggvo8VFOtvPLpovwq6fLceeiFK0Wci0Q@mail.gmail.com>
 <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121005125821.GA7937@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> The Nomadik NAND driver is really just a subset of the existing
>> FSMC driver,
>>
>> Cc: Alessandro Rubini <rubini@unipv.it>

> Still requesting Mike's ACK, but not for merging through ARM SoC
> but through MTD.

Oh, and please get mine too. Sorry for not noticing the message, busy
times...

I'm pretty sure there was no fsmc driver back then. But clearly
something coming from the vendor and used on several boards is better
then something made by an external consultant for a specific
evaluation board. So ok to ditch my nand driver.

Acked-by: Alessandro Rubini <rubini@unipv.it>
