From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Mar 2013 21:21:33 +0100
Subject: ep93xx irq-vic regression
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020980106CB7@AUSP01VMBX24.collaborationhost.net>
References: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
 <5143AAB4.6020406@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020980106CB7@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACRpkdb9tpeTxEc8A24vTkcUsfd=gQpMub0KpgaKJjrGf-fSvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 16, 2013 at 1:16 AM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:

> It looks like the commit above _did_ have a couple bugs but they were
> fixed:

Oh thanks, I already was scared I had broken something again.
The irqdomain stuff is a bit fragile, everytime I refactor something
it blows up in my face. I hope there are no remaining problems.

Yours,
Linus Walleij
