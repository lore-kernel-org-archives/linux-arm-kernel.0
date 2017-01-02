From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 2 Jan 2017 17:03:03 +0100
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <CAFcVECLg-hXvfgwRW-fxi+N0k=7pTaEMhS5EMXV9_OO+xGRUqA@mail.gmail.com>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <CAFcVECLg-hXvfgwRW-fxi+N0k=7pTaEMhS5EMXV9_OO+xGRUqA@mail.gmail.com>
Message-ID: <20170102160303.GC3609@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 05:13:34PM +0530, Harini Katakam wrote:
> From the revision history of Cadence spec, all versions starting
> r1p02 have ability to include timestamp in descriptors.

So why not add code to read the version, hm?

> For previous versions the event register is the only option.

And is it true that the regsiters do not latch the time stamp?

If so, then the IP core is more than useless.

Thanks,
Richard
