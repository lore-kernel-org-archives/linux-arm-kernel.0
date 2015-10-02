From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 17:55:48 +0100
Subject: [PATCH v2 0/2] Add support to make output voltage determined by
 VSET2[] bits
In-Reply-To: <1443597950-27849-1-git-send-email-wenyou.yang@atmel.com>
References: <1443597950-27849-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20151002165548.GT12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 03:25:48PM +0800, Wenyou Yang wrote:
> The patch is to add support to make the output voltage of ACT8865
> DC/DC regulator determined by VSET2[] bits. The DT property
> "active-semi,vsel-high" is used to specify the VSEL pin at high
> on the board. When the VSEL pin is high, output voltage is programmed
> by VSET2[] bits.

I'll apply these but they'll probably need some rework when someone
needs to support a board where the pin is connected to a GPIO and
controllable for fast voltage switching.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/76a41052/attachment-0001.sig>
