From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 15 Apr 2015 14:34:03 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <CAF6AEGtoxNrCoxT5n0CXmKMnL-YprJ3DkAuM4Myi87WMxPqBGw@mail.gmail.com>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <20150410100529.GA6854@e104818-lin.cambridge.arm.com>
 <20150414163613.GM28709@leverpostej>
 <07185B2C-3F37-4E70-9096-1EF5EA8D68CE@codeaurora.org>
 <20150414211720.GA56647@MBP>
 <CAF6AEGtoxNrCoxT5n0CXmKMnL-YprJ3DkAuM4Myi87WMxPqBGw@mail.gmail.com>
Message-ID: <20150415133403.GB26099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 05:48:48PM -0400, Rob Clark wrote:
> Just speaking as an outsider to this topic, but seems like most/all
> tablets/phones/etc ship with signed firmware.  Which means for most of
> the population, upgrading the firmware to a new version which did
> support the standard (assuming it existed), isn't really an option on
> our devices, any more than fixing buggy acpi tables is on our
> laptops..

I wouldn't expect most population to build their own kernels on
tablets/phones. And even if you could install a custom kernel, mainline
rarely runs on such devices because of tons of out of tree patches (just
look at the Nexus 9 patches that Kumar pointed at; even ignoring the
booting protocol they are extremely far from an upstreamable form).

-- 
Catalin
