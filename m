From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 17:22:02 -0500
Subject: [PATCH] memory: Convert to using %pOF instead of full_name
In-Reply-To: <20170719054702.x6h2fkz6vplzyqg2@piout.net>
References: <20170718214339.7774-34-robh@kernel.org>
 <20170719054702.x6h2fkz6vplzyqg2@piout.net>
Message-ID: <CAL_JsqKLCWVY09RHgU71oc+QMa_bWg+t_yhb60iKFShFT41YPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 12:47 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 18/07/2017 at 16:43:14 -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-omap at vger.kernel.org
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

This can go through subsystem tree. Who normally takes drivers/memory/
changes? arm-soc?

Rob
