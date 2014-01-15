From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jan 2014 11:50:06 +0000
Subject: [PATCH v4 6/6] regmap: spmi: support base and extended register
 spaces
In-Reply-To: <39f0fd65345f4c2b75b036234514ca02279fc21f.1389738151.git.joshc@codeaurora.org>
References: <cover.1389738151.git.joshc@codeaurora.org>
 <39f0fd65345f4c2b75b036234514ca02279fc21f.1389738151.git.joshc@codeaurora.org>
Message-ID: <20140115115006.GJ15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 12:41:40PM -0600, Josh Cartwright wrote:
> SPMI states that a slave may contain two register spaces, the Base
> register space is a 5-bit byte-addressable space accessed via the
> Register Read/Write and Register Zero Write command sequences, and the

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140115/5c25fed0/attachment.sig>
