From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 15:32:57 +0000
Subject: [PATCH 01/11] irqchip: sun4i: fix compilation outside of arch/arm
In-Reply-To: <56B0C768.3020805@gmail.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-2-git-send-email-andre.przywara@arm.com>
 <56B0C768.3020805@gmail.com>
Message-ID: <56B0CC29.4060703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 15:12, Matthias Brugger wrote:
> On 01/02/16 18:39, Andre Przywara wrote:
>> The Allwinner sunxi specific interrupt controller cannot be compiled
>> for any architecture except arm:
> 
> s/arm/arm64

???

As it stands it only compiles for arm, and not arm64, so "cannot be
compile for any architecture except arm" is the right thing to say, no?

Or did I get confused by my own double negation?

Cheers,
Andre.
