From: broonie@kernel.org (Mark Brown)
Date: Sun, 10 Jan 2016 11:58:58 +0000
Subject: [PATCH 2/5] clk: bcm2835: enable management of PCM clock
In-Reply-To: <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
 <4332640.jBKM55TPAo@wuerfel>
 <CAMuHMdWOt4aCzu8Ode0ZrQ-c80nqAhwD5dd17nhgVbLrRYT5og@mail.gmail.com>
 <4B891DE1-6340-4D3D-BEE3-F61D9A5D289B@martin.sperl.org>
Message-ID: <20160110115858.GV6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 10, 2016 at 11:55:48AM +0100, Martin Sperl wrote:

> So if someone with a better idea how to keep those dt-binding includes
> synchronized with the definitions used by the code step forward and
> propose a better solution how to get that implemented?

> I guess there will be a few more occurrences of clocks that are
> currently not defined, which will need to get introduced in the future
> PWM and PCM were just the last in this series.

Presumably just making the code not rely on having a define for the
number of clocks would deal with the problem (eg, using ARRAY_SIZE
internally).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160110/4fba2e82/attachment.sig>
