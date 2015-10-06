From: schwab@suse.de (Andreas Schwab)
Date: Tue, 06 Oct 2015 12:59:45 +0200
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <5340366.WTVksOGb0G@wuerfel> (Arnd Bergmann's message of "Tue, 06
 Oct 2015 12:51:24 +0200")
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
 <20151006103128.GN6281@e103592.cambridge.arm.com>
 <5340366.WTVksOGb0G@wuerfel>
Message-ID: <mvmh9m48dpa.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> I think it makes sense to stick with the traditional definition
> of MINSIGSTKSZ == "the minimum amount that you will always need,
> add whatever you require yourself" and SIGSTKSZ == "Should be
> enough for a couple of function calls".

The python3 testsuite wants to put two signal frames in a SIGSTKSZ
stack.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
