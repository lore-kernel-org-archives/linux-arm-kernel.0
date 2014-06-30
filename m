From: schwab@suse.de (Andreas Schwab)
Date: Mon, 30 Jun 2014 15:56:50 +0200
Subject: [PATCH] arm64/crypto: fix makefile rule for aes-glue-%.o
In-Reply-To: <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
 (Ard Biesheuvel's message of "Mon, 30 Jun 2014 15:38:41 +0200")
References: <mvmvbri4k06.fsf@hawking.suse.de>
 <CAKv+Gu-NAVjMR-Jkw=W-8f7M5FSsQOSdzYN6A0kHDd1m0WA8EA@mail.gmail.com>
Message-ID: <mvmr4264i1p.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

> Out of curiosity, how did you trigger this failure? I have build this
> code numerous times (and so have others) and I have never seen this
> failure.

Did you ever start with a clean tree?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
