From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Oct 2012 08:53:08 +0100
Subject: [PATCH] ARM: sort select statements alphanumerically
In-Reply-To: <CAMPhdO-SuJwz4uN=1sQWtr3WOn656_M9iEGkMDjtOKTrsMUDpg@mail.gmail.com>
References: <E1TKX8k-0006QP-M5@rmk-PC.arm.linux.org.uk>
 <CAMPhdO-SuJwz4uN=1sQWtr3WOn656_M9iEGkMDjtOKTrsMUDpg@mail.gmail.com>
Message-ID: <20121008075308.GF28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 10:50:00AM +0800, Eric Miao wrote:
> BTW, maybe we also need to sort the ARCH_XXX in alphanumeric order, so
> new ARCH will find a better place to live?

They should be sorted according to option text already - this is to
allow people using the configuration tool to easily find the right
option to select in that long list.  That's something I did well
before arm-soc.

It looks pretty good at the moment, except for the following two:

        bool "Cavium Networks CNS3XXX family"
        bool "NXP LPC32XX"
