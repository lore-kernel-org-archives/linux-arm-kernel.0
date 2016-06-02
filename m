From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Jun 2016 11:25:48 -0700
Subject: [PATCH 04/34] clk: bcm2835: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-5-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-5-stephen.boyd@linaro.org>
Message-ID: <87r3cfa1n7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <stephen.boyd@linaro.org> writes:

> Now that we have clk_hw based provider APIs to register clks, we
> can get rid of struct clk pointers while registering clks in
> these drivers, allowing us to move closer to a clear split of
> consumer and provider clk APIs.

This looks good, but it'll conflict with the fixes for 4.7.  Could we
land those first and then put this commit on top of that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160602/0b5d427d/attachment.sig>
