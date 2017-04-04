From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 04 Apr 2017 09:44:04 +0200
Subject: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <20170404073504.GI16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org> <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org>
Message-ID: <1491291844.6218.25.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-04 at 16:35 +0900, AKASHI Takahiro wrote:
> 
> Because I think that people sometimes use those two interchangeably.
> So I said I would defer to the maintainers.

Sometimes they do, yes. Just as sometimes people use "their",
"they're", and "there" interchangeably.

Rarely in a professional context, though. And even more rarely when
their error has already been pointed out to them.

There are no good reasons to *deliberately* get it wrong.

I've heard it suggested that 'MiB' would confuse people who have never
seen it before. And that it was ugly. Those arguments were fairly
specious when they were first made, and they're even sillier now ? more
than 20 years since the binary prefixes were introduced.

The alleged confusion, and the perceived ugliness, are purely due to
unfamiliarity and will pass.

The correctness, and the lack of ambiguity, will not.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/bdec67f5/attachment-0001.bin>
