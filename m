From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Jan 2014 22:08:50 -0500 (EST)
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jan 2014, Olof Johansson wrote:

> "for SDIO slots" is somewhat misleading; nearly all controllers only
> do one slot/device per controller. The designware controller can do
> multiple slots, and that adds a bit of driver and binding complexity
> for something that seemingly not a single vendor has actually
> implemented.

The Marvell 8688, just to name one, does both WIFI and BlueTooth over 
the same SDIO controller using separate functions/slots.

Or maybe I'm misunderstanding you?


Nicolas
