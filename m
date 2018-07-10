From: alan@wylie.me.uk (Alan J. Wylie)
Date: Tue, 10 Jul 2018 20:28:04 +0100
Subject: [PATCH 0/2] arm64: spectre-v1 write fixes (CVE-2018-3693)
In-Reply-To: <20180710180123.56461-1-mark.rutland@arm.com> (Mark Rutland's
 message of "Tue, 10 Jul 2018 19:01:21 +0100")
References: <20180710180123.56461-1-mark.rutland@arm.com>
Message-ID: <87d0vuao1n.fsf@wylie.me.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> These patches inhibit spectre-v1-write gadgets found in arch/arm64, using the
> same mitigation applied to existing spectre-v1-read gadgets.
>
> This issue is also known as CVE-2018-3693, or "bounds check bypass store".
> More details can be found in the Arm Cache Speculation Side-channels
> whitepaper, available from the Arm security updates site [1].

> [1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability

>From that web page:

| Variant 1: bounds check bypass store (CVE-2017-5753) and bounds check
| bypass store (CVE-2018-3693)

Isn't -5753 a "read" vulnerability, not "store"?

-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
