From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Aug 2015 11:44:58 +0100
Subject: [PATCH v2] ARM: add boot image dependencies to not generate
 invalid images
In-Reply-To: <1439049211-4181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1439049211-4181-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150818104458.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 09, 2015 at 12:53:31AM +0900, Masahiro Yamada wrote:
> U-Boot is often used to boot the kernel on ARM boards, but uImage
> is not built by "make all", so we are often inclined to do
> "make all uImage" to generate DTBs, modules and uImage in a single
> command, but we should notice a pitfall behind it.  In fact,
> "make all uImage" could generate an invalid uImage if it is run with
> the parallel option (-j).

Please put this patch in the patch system.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
