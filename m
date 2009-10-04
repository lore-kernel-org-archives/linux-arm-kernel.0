From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Oct 2009 13:22:38 +0100
Subject: [PATCH 4/6] Made totalhigh_pages unsigned long.
In-Reply-To: <1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20091004122237.GC26794@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 12:48:59PM +0200, Andreas Fenkart wrote:
> Makes it consistent with the extern declaration, used when
> CONFIG_HIGHMEM is set

The linux/highmem.h part needs to go to someone like Andrew Morton,
cc'd LKML.
