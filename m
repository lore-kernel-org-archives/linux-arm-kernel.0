From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2015 18:17:16 +0100
Subject: [PATCH] arm: wire up userfaultfd and membarrier syscalls
In-Reply-To: <1442854833-10592-1-git-send-email-andre.przywara@arm.com>
References: <1442854833-10592-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150921171715.GR21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 06:00:33PM +0100, Andre Przywara wrote:
> Add the syscall numbers to the ARM syscall table. Both have
> been briefly tested using the provided selftests from the tools
> directory.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi Russell,
> 
> I saw that Thierry sent something similar beginning of August already
> (which is now outdated), is there any issue with enabling syscalls?

The only issue there is is that this was mentioned last week, and I
replied about it last week.

I already have a patch pending for it, but I've been unable to merge
it into mainline as my tree became somewhat messy due to the fixes
missing -rc1 - which meant that my fixes branch was not recent enough
to take that patch.  Now that those fixes are in, I can now start
sorting my tree out, as I'd normally do after -rc1.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
