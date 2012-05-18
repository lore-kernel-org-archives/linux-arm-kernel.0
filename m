From: robherring2@gmail.com (Rob Herring)
Date: Thu, 17 May 2012 21:12:04 -0500
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120517233512.GH16338@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <20120517233512.GH16338@titan.lakedaemon.net>
Message-ID: <4FB5AFF4.7060900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 06:35 PM, Jason Cooper wrote:
> On Tue, May 15, 2012 at 08:31:06AM -0500, Rob Herring wrote:
>> marvell is the documented vendor string, not mrvl.
> 
> When Arnd and I were adding the initial kirkwood support for devicetree,
> the common wisdom was to use the stock ticker symbol when available.
> Hence, mrvl, iom, and dlink (only on taiwanese exchange, which uses
> numbers)...

Yes, that's true. But consistency is more important. If we have cases of
both, then one needs to be deprecated.

Rob
