From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 26 Nov 2014 21:07:33 +0000
Subject: [PATCH v2 2/2] of: support passing console options with
 stdout-path
In-Reply-To: <20141126183052.GH3443@lunn.ch>
References: <1417023640-23464-1-git-send-email-leif.lindholm@linaro.org>
 <1417023640-23464-3-git-send-email-leif.lindholm@linaro.org>
 <20141126183052.GH3443@lunn.ch>
Message-ID: <CACxGe6tYZ8aE_TKw1cYMY5DDjpSXPSnhhAam-rG5NgdjpKJe+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 6:30 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Nov 26, 2014 at 05:40:40PM +0000, Leif Lindholm wrote:
>> Support specifying console options (like with console=ttyXN,<options>)
>> by appending them to the stdout-path property after a separating ':'.
>>
>> Example:
>>         stdout-path = "uart0:115200";
>
> Hi Leif
>
> This should be documented somewhere under
> Documentation/devicetree/bindings/
>
> Not sure where thought. Maybe a top level chosen.txt?

Actually, this one doesn't. It is already documented in ePAPR

g.
