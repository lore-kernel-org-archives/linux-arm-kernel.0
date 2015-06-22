From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jun 2015 16:16:47 +0100
Subject: BUG: Bad page state in process swapper pfn:XXXXX
In-Reply-To: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
References: <CAFdej03jedihbdNCb8e+at3M3ikKxn+s6eAvBvfGPdtsHShQdQ@mail.gmail.com>
Message-ID: <20150622151647.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 08:04:17PM +0530, Arun Chandran wrote:
> Hi,
> 
> I am booting the latest linus tree on altera cyclone5 soc development kit.
> (https://www.altera.com/products/boards_and_kits/dev-kits/altera/kit-cyclone-v-soc.html)
> With the dtb file arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb.
> 
> I get these BUGS (page dumped because: non-NULL mapping) randomly; occurs
> around 1 in 5 times during cold boots.

When did the problem start?  Are older kernel versions stable?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
