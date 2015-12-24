From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Dec 2015 15:45:15 -0800
Subject: [PATCH v2 1/3] clk: bcm2835: Add bindings for the auxiliary
 peripheral clock gates.
In-Reply-To: <CAEG3pNCOO1F8+nwOQGSjUKxYCGbWW_Ripc6xUwDyg6ay66uL7w@mail.gmail.com>
References: <1450222559-22461-1-git-send-email-eric@anholt.net>
 <20151219041935.GS14936@rob-hp-laptop>
 <CAEG3pNCOO1F8+nwOQGSjUKxYCGbWW_Ripc6xUwDyg6ay66uL7w@mail.gmail.com>
Message-ID: <87wps3qulw.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@baylibre.com> writes:

> On Fri, Dec 18, 2015 at 8:19 PM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Dec 15, 2015 at 03:35:57PM -0800, Eric Anholt wrote:
>>> These will be used for enabling UART1, SPI1, and SPI2.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>
>>> v2: Make the binding cover both the IRQ and clock enable registers.
>>>
>>>  .../bindings/clock/brcm,bcm2835-aux-clock.txt      | 31 ++++++++++++++++++++++
>>>  include/dt-bindings/clock/bcm2835-aux.h            | 17 ++++++++++++
>>>  2 files changed, 48 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
>>>  create mode 100644 include/dt-bindings/clock/bcm2835-aux.h
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Applied to clk-next.
>
> Next time if you put the header into the clk driver patch then we can
> send the binding description through the DT tree and take the header
> and C file through the clk tree in one patch.

I would *love* to do that, but I've previously been told that having the
bindings patch reference a header file not present as of the bindings
patch is not acceptable and made to change it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/3f457eec/attachment.sig>
