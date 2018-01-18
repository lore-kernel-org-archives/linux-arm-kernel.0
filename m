From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 18 Jan 2018 07:09:23 -0800
Subject: [PATCH v4 4/8] PCI: brcmstb: Add dma-range mapping for
 inbound	traffic
In-Reply-To: <20180118073123.GA15766@lst.de>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-5-git-send-email-jim2101024@gmail.com>
 <CAL_JsqKpWNJXNpKS5qC99N0+H_P37DcRE-rN9HFwT5tVmRFCNw@mail.gmail.com>
 <20180118073123.GA15766@lst.de>
Message-ID: <EDAEFB0F-BB7C-444A-B282-F178F5ADFCBF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On January 17, 2018 11:31:23 PM PST, Christoph Hellwig <hch@lst.de> wrote:
>On Wed, Jan 17, 2018 at 08:15:33PM -0600, Rob Herring wrote:
>> > (a) overriding/redefining the dma_to_phys() and phys_to_dma() calls
>> > that are used by the dma_ops routines.  This is the approach of
>> >
>> >         arch/mips/cavium-octeon/dma-octeon.c
>> 
>> MIPS is rarely an example to follow. :)
>
>But in this case it actually is the example to follow as told
>previously.
>
>NAK again for these chained dma ops that only create problems.

Care to explain what should be done instead?

-- 
Florian
