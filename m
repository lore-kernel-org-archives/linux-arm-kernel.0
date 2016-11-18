From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Nov 2016 17:57:30 +0000
Subject: [PATCHv3 0/6] CONFIG_DEBUG_VIRTUAL for arm64
In-Reply-To: <1479431816-5028-1-git-send-email-labbott@redhat.com>
References: <1479431816-5028-1-git-send-email-labbott@redhat.com>
Message-ID: <20161118175730.GF1197@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 05:16:50PM -0800, Laura Abbott wrote:
> Hi,

Hi,

Thanks again for putting this together.

> This is v3 of the series to add CONFIG_DEBUG_VIRTUAL for arm64.
> The biggest change from v2 is the conversion of more __pa sites
> to __pa_symbol for stricter checks.

Patches 1-4 look good to me, and I've given them a spin in a few
configurations on arm64. For those:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Patches 5 and 6 look like they're mostly there, but there are still a
few issues which I've commented on. Hopefully those aren't too painful
to sort out; it would be great to have this available.

Thanks,
Mark.
