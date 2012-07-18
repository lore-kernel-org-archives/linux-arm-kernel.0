From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 18 Jul 2012 21:47:05 +0530
Subject: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
In-Reply-To: <20120627114003.GG308@opensource.wolfsonmicro.com>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
 <20120622123013.GA7586@sirena.org.uk>
 <20120622131750.GB19226@n2100.arm.linux.org.uk>
 <20120622161155.GM4037@opensource.wolfsonmicro.com>
 <20120625111847.GE19226@n2100.arm.linux.org.uk>
 <20120627114003.GG308@opensource.wolfsonmicro.com>
Message-ID: <CAMQu2gygvOeWrOPBnc=21oTPWWnFG8go5gcxAJ5UfDTG+cPRLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Peter,

On Wed, Jun 27, 2012 at 5:10 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 25, 2012 at 12:18:47PM +0100, Russell King - ARM Linux wrote:
>
>> It appears to be something to do with the jack detection that's going wrong.
>> If I start the audio with the jack disconnected, I never get anything out
>> of the board.  It requires the jack to be connected before the first use.
>> The on-board speakers used to work without the jack plugged in at one time
>> but they seem to be completely non-functional now.
>
>> Confused.
>
> Me too - there's nothing obvious in the code just from inspection that
> would affect this.

Does audio work with $subject series after your mux fixes which
you posted recently.

Regards
Santosh
