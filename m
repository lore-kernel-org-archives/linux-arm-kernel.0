From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Feb 2016 11:47:33 +0000
Subject: [PATCH] ARM: don't print missing L2 cache as error
In-Reply-To: <d67716f9edf83700b18532eb66980316@agner.ch>
References: <1453944439-1070-1-git-send-email-stefan@agner.ch>
 <d67716f9edf83700b18532eb66980316@agner.ch>
Message-ID: <20160216114733.GC19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 07:19:20PM -0800, Stefan Agner wrote:
> Hi Russel,
> 
> Any comment to this? Currently the kernel prints an error message as
> follows on the platform at hand:
> [    0.000000] L2C: failed to init: -19

An alternative patch (8499/1) is queued for the next merge window, as it
isn't a regression and isn't a bug per se.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
