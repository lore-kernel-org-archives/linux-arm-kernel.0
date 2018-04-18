From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Apr 2018 18:02:50 +0100
Subject: [v2,2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180417182347.GD244487@google.com>
References: <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <20180417182347.GD244487@google.com>
Message-ID: <20180418170250.GL10061@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 11:23:47AM -0700, Matthias Kaehlcke wrote:
> On Fri, Apr 13, 2018 at 07:50:35PM -0700, David Collins wrote:
> > Add the QCOM RPMh regulator driver to manage PMIC regulators
> > which are controlled via RPMh on some Qualcomm Technologies, Inc.
> > SoCs.  RPMh is a hardware block which contains several

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180418/221bb544/attachment.sig>
