From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jun 2018 18:08:12 +0100
Subject: [PATCH v2 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is
 not enabled
In-Reply-To: <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180605170812.d5ewm5crou3qnkuh@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 03:35:03PM +0100, Sudeep Holla wrote:
> Though CONFIG_ACPI_PPTT is selected by platforms and nor user visible,
> it may be useful to support the build with CONFIG_ACPI_PPTT disabled.
> 
> This patch adds the missing dummy/boiler plate implementation to fix
> the build.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/acpi.h      | 15 +++++++++++++++
>  include/linux/cacheinfo.h |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)

I queued this patch for now, it's a good clean-up regardless of whether
we disable PPTT temporarily or not.

Thanks.

-- 
Catalin
