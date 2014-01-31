From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 11:11:42 -0800
Subject: [PATCH 0/4] Split mach-msm into legacy and mach-qcom
 (multiplatform)
In-Reply-To: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
References: <1391107002-21470-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140131191142.GB32295@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:36:38PM -0600, Kumar Gala wrote:
> This is the starts of splitting the Qualcomm MSM platform into legacy support
> that we will not try and convert to multiplatform and multiplatform support.
> These patches are based on the 'CPU enable method based SMP' patches.
> 
> I wanted to get these out for review, will add a few more patches for defconfig
> updates/additions, as well as some additional driver being enabled for ARCH_QCOM.

Series:

Acked-by: Olof Johansson <olof@lixom.net>

See comment on the MAINTAINERS addition; let me know how you prefer to send us
patches. We can apply from mailing lists we just need to know your preference.


-Olof
