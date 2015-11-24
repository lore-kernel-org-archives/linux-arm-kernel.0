From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 24 Nov 2015 04:29:39 -0700
Subject: [PATCH v3 12/62] ACPICA: ACPI 6.0: Add changes for FADT
 table
In-Reply-To: <1447753261-7552-13-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-13-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5654583302000078000B85A6@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> ACPICA commit 72b0b6741990f619f6aaa915302836b7cbb41ac4
> 
> One new 64-bit field at the end of the table.
> FADT version is now 6.
> 
> Link: https://github.com/acpica/acpica/commit/72b0b674 
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [Linux commit aeb823bbacc2a3aaee29eda5875b58a049fa1f78]
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/include/acpi/actbl.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

So while I applied this one after fixing it up, I'm not going to do any
further fixups to later patches I also meant to apply. I realize the
fixups may have been necessary because of me applying them in
other than the submitted sequence, but then again such general
imports from ACPICA/Linux should have been independent of
earlier changes. I.e. either earlier patches in the series wrongly
touch these headers, or there's a general problem with the series.

Jan
