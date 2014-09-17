From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Wed, 17 Sep 2014 02:44:10 +0100
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140917014410.GC31214@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:

> +Common _DSD bindings should be submitted to ASWG to be included in the
> +document :-
> +
> +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm

How are individuals/companies who aren't UEFI members supposed to do 
this? Aren't there IP issues involved in taking submissions from 
non-members?

> +No code shall be accepted into the kernel unless it complies with the released
> +standards from UEFI ASWG. If there are features missing from ACPI to make it
> +function on a platform, ECRs should be submitted to ASWG and go through the
> +approval process.

Similar question here. Is the expectation that all ARM vendors will 
become UEFI contributors?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
