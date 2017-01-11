From: Andrei.Pistirica@microchip.com (Andrei.Pistirica at microchip.com)
Date: Wed, 11 Jan 2017 14:34:13 +0000
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <20170103111447.GA26488@localhost.localdomain>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
 <20170102161359.GD3609@localhost.localdomain>
 <CAFcVECK1vt7Hu4tgSZ2+kKpMxoT-wpikMDq65HaxRv-EMgobHA@mail.gmail.com>
 <BN3PR07MB25168573DD82F1681CDC8437C96E0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170103111447.GA26488@localhost.localdomain>
Message-ID: <07C910AB6AC6C345A093D5A08F5AF568CB77996E@CHN-SV-EXMX03.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> On Tue, Jan 03, 2017 at 10:47:56AM +0000, Rafal Ozieblo wrote:
> > We could use only descriptor approach but there are many Atmel's cores
> on the market which support only event registers.
> 
> As I said in my other reply in this thread, the Atmel cores cannot possibly be
> made to work correctly.
> 
> Sad, but true.

In conscience, I will make a patch containing only the common code (just to benefit from this effort) and then Rafal can add the driver for the GXL version on top of it.
Everybody agrees with this?

Best regards,
Andrei

> 
> Thanks,
> Richard
