From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Jun 2014 16:08:28 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <mvmr4264i1p.fsf@hawking.suse.de>
References: <mvmvbri4k06.fsf@hawking.suse.de>
 <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
 <mvmr4264i1p.fsf@hawking.suse.de>
Message-ID: <CAKv+Gu8SbM_Z=ymBFb2D4EWJeo-6dWuKqE2YNOkqJTKLDEJcYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 June 2014 15:56, Andreas Schwab <schwab@suse.de> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> Out of curiosity, how did you trigger this failure? I have build this
>> code numerous times (and so have others) and I have never seen this
>> failure.
>
> Did you ever start with a clean tree?
>

Yep, building both in-tree and out-of-tree, no trouble at all.

-- 
Ard.
