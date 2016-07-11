From: daniel@0x0f.com (Daniel Palmer)
Date: Mon, 11 Jul 2016 22:03:38 +0900
Subject: sh-eth.c writes to non-existent register on RZ/A1
In-Reply-To: <KL1PR06MB1749BFFCB144EE55402339968A3F0@KL1PR06MB1749.apcprd06.prod.outlook.com>
References: <CAFr9PXniO=qPUpok1dVHzjrEpKVo6t3koc2n=UCjWrdD_DL+5A@mail.gmail.com>
 <KL1PR06MB1749BFFCB144EE55402339968A3F0@KL1PR06MB1749.apcprd06.prod.outlook.com>
Message-ID: <CAFr9PX=h4ftOUu3+0fOC9VHyjQNzLVZPHj8b260G_VUCq7-8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 July 2016 at 21:27, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> You might have better luck posting Renesas device questions to the Renesas mailing list.
>
> http://vger.kernel.org/vger-lists.html#linux-renesas-soc

Ok, I will forward my original mail there.

> It's on my list of things to do in the next couple months to push in all the RZ/A1 BSP driver changes back upstream. After I got the XIP_LINUX fixes in earlier this year, I got a bit side tracked on other projects.

I have hacked up versions of the BSP PFC, ADC, RTC, DMAC and USB
drivers running on top of 4.7rc6. :)
