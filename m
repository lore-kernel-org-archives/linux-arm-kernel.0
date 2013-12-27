From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 27 Dec 2013 04:56:30 +0000
Subject: [PATCH v4 3/5] ACPI: HW reduced mode does not allow use of the
 FADT sci_interrupt field
In-Reply-To: <1387239401-13918-4-git-send-email-al.stone@linaro.org>
References: <1387239401-13918-1-git-send-email-al.stone@linaro.org>
 <1387239401-13918-4-git-send-email-al.stone@linaro.org>
Message-ID: <20131227045630.GA21429@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 05:16:39PM -0700, al.stone at linaro.org wrote:

> +	if (!acpi_gbl_reduced_hardware) {

I don't really understand this. You've explained that runtime hardware 
reduced mode switching isn't expected to work, but you're making this 
conditional on a runtime flag?

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
