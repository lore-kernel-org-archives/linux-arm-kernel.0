From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Nov 2014 19:30:52 +0100
Subject: [PATCH v2 2/2] of: support passing console options with
 stdout-path
In-Reply-To: <1417023640-23464-3-git-send-email-leif.lindholm@linaro.org>
References: <1417023640-23464-1-git-send-email-leif.lindholm@linaro.org>
 <1417023640-23464-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20141126183052.GH3443@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:40:40PM +0000, Leif Lindholm wrote:
> Support specifying console options (like with console=ttyXN,<options>)
> by appending them to the stdout-path property after a separating ':'.
> 
> Example:
>         stdout-path = "uart0:115200";

Hi Leif

This should be documented somewhere under
Documentation/devicetree/bindings/

Not sure where thought. Maybe a top level chosen.txt?

    Andrew
