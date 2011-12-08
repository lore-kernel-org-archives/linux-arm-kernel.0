From: sakoman@gmail.com (Steve Sakoman)
Date: Thu, 8 Dec 2011 15:07:13 -0800
Subject: [PATCH] ARM: OMAP3: hwmod data: disable multiblock reads on
 MMC1/2 on OMAP34xx/35xx <= ES2.1
In-Reply-To: <alpine.DEB.2.00.1112081541170.6289@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110061453540.4611@utopia.booyaka.com>
 <CAGDS+nnm_+9975aX9h7U7EUf6UDWiiqO8+yfG_zW1sCxhgrzQw@mail.gmail.com>
 <alpine.DEB.2.00.1112081541170.6289@utopia.booyaka.com>
Message-ID: <CAGDS+nnASzgu4Xrvm2zqQ2H3uUtZWiKNC+Gb5saqZVLA=-7Scw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2011 at 2:51 PM, Paul Walmsley <paul@pwsan.com> wrote:

> Thanks for the reminder - I would have forgotten it otherwise.
>
>> Without it 35XXES2.1 systems have broken mmc. ?Too late as a bug fix for
>> 3.2?
>
> This never worked correctly in previous Linux releases, right?

I seem to recall that it worked a few releases back -- perhaps before
multiblock reads??

It's been broken for a while though, so waiting for 3.3 isn't the end
of the world.

I'll add the patch to my 3.2 builds to put some miles on it :-)

Steve
