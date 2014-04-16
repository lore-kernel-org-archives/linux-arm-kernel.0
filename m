From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Apr 2014 09:29:41 +0100
Subject: [PATCH] ARM: prima2: remove L2 cache size override
In-Reply-To: <CAGsJ_4zKz=O8FAkuTj8uw=J840qpCb5FWq_sarJBfMHZvz1-sg@mail.gmail.com>
References: <1397555342-25644-1-git-send-email-21cnbao@gmail.com>
 <20140415100002.GQ24070@n2100.arm.linux.org.uk>
 <CAGsJ_4zt4KMLk7v93e40Zj1A7fHBnvE2_c94nAbGAr9xcCFnwg@mail.gmail.com>
 <20140415215615.GZ24070@n2100.arm.linux.org.uk>
 <CAGsJ_4zKz=O8FAkuTj8uw=J840qpCb5FWq_sarJBfMHZvz1-sg@mail.gmail.com>
Message-ID: <20140416082940.GC24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 04:24:34PM +0800, Barry Song wrote:
> yes. i meant if that has been done in bootloader, it turns out we
> don't care about which callback is better any more. and for linux
> running in non-security, same.

However, I don't think it's quite as simple as that, because things
like the Cortex A9 Full-Line-Of-Zeros feature need a specific enable
sequence which (I think) can't be done in the boot loader.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
