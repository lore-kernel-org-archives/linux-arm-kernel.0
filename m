From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Sep 2014 09:46:16 +0100
Subject: [RFC] arm:extend the reserved mrmory for initrd to be page aligned
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB4915FC@CNBJMBX05.corpusers.net>
Message-ID: <20140915084616.GX12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 01:11:14PM +0800, Wang, Yalin wrote:
> this patch extend the start and end address of initrd to be page aligned,
> so that we can free all memory including the un-page aligned head or tail
> page of initrd, if the start or end address of initrd are not page
> aligned, the page can't be freed by free_initrd_mem() function.

Have you tested this patch?  If so, how thorough was your testing?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
