From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Dec 2016 13:50:16 +0000
Subject: [PATCHv5 00/11] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <1481068257-6367-1-git-send-email-labbott@redhat.com>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
Message-ID: <20161213135015.GC24607@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:50:46PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is v5 of the series to add CONFIG_DEBUG_VIRTUAL for arm64. This mostly
> contains minor fixups including adding a few extra headers around and splitting
> things out into a few more sub-patches.
> 
> With a few more acks I think this should be ready to go. More testing is
> always appreciated though.

I've given the whole series a go with kasan, kexec, and hibernate (using
test_resume with the disk target), and everything looks happy. So FWIW,
for the series:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Hopefully this can be queued soon for v4.11!

Thanks,
Mark.
