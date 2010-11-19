From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Nov 2010 12:00:32 +0000
Subject: [PATCH 0/5] Clean up page tables
In-Reply-To: <20101117172717.GF5308@n2100.arm.linux.org.uk>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimOgLU+F5JLWU=Tbm3KM-snPeCEB5WLWPZ-b3v6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 17:27, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This patch series is preparation for LPAE, allowing a cleaner
> transition from the current methodology to that required for
> LPAE.

Apart from a few things I raised (after which you can even add my ack
for all of them), the LPAE patches work fine on top of your series.

What are your plans for upstream? It looks like stuff for 2.6.38 but
it would be good if in the meantime you make them available on some
branch (just these patches) so that I can rebase my LPAE work on top
without carrying your patches.

Thanks.

-- 
Catalin
