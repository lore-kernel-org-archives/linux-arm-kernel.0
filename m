From: rubini@unipv.it (Alessandro Rubini)
Date: Tue, 22 Nov 2011 16:19:42 +0100
Subject: [GIT PULL] ARM: amba: Enable module alias autogeneration for
 AMBA drivers
In-Reply-To: <20111122120756.GF2066@localhost.localdomain>
References: <20111122120756.GF2066@localhost.localdomain>
 <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
 <20111122115632.GA5165@mail.gnudd.com>
Message-ID: <20111122151942.GA24821@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>   lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
>>   lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
>>   lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).
> 
> Splitting this up doesn't look like a silly idea -- I thought it was
> unfortunate to have to patch a core file just to add a bus type.
>
> I guess the question is how many new buses we get over time.

Well, CERN will have 2 in a short time. And I'm sure the bus concept
is so good that a number of them exists as external patches. Being
forced to patch a core file is not good, with conflicts that accumulate
over time.

I'd better be able to drop in my own file and add a kconfig-aware line
in Makefile.  I think the implementation is straightforward. Who should
I send it to?

thanks
/alessandro
