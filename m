From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2016 11:29:59 +0100
Subject: [PATCH 06/12] ARM: kexec: advertise location of bootable RAM
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviF4-0000jG-MO@rmk-PC.arm.linux.org.uk>
 <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <20160503102959.GM19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 08:26:00PM +0530, Pratyush Anand wrote:
> Can you please also share git tree path of corresponding kexec-tools changes?

On their way as a 32-patch series.  I've found the userspace tools to be
in particularly poor shape, so some of the patches are fixing that up.
I can't believe that anyone uses these userspace tools, because there
are some fundamental bugs present in this code which go back years.
However, the repository does seem to be maintained, with the latest
commit within the last two months (or day when I started working on
this.)

They're based upon 2.0.12-rc1 (93d3a617) of the

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

repository, which was the latest commit when I started working on this
back in March.  Things may have moved forwards since then - I've not
been able to check yet.  However, this set of changes should be
sufficient to get an idea of what's required on the userspace side.

Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
