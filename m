From: broonie@kernel.org (Mark Brown)
Date: Wed, 25 Apr 2018 17:21:41 +0100
Subject: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add apq8096 machine
 bindings
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Message-ID: <20180425162141.GG24769@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 10:04:54AM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 11:49 AM, Srinivas Kandagatla

> If you don't have the values, then how does one validate a DT is correct?

> Honestly, a single property like this seems insufficient to describe
> audio routing.

It's perfectly fine, it's a list of source to sink mappings which can
handle any set of N:M links.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/16d56546/attachment-0001.sig>
