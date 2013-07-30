From: cjb@laptop.org (Chris Ball)
Date: Tue, 30 Jul 2013 17:40:16 +0100
Subject: [PATCH] mmc: sdhci-msm: Add support for MSM chipsets
In-Reply-To: <1375201355-26906-1-git-send-email-gdjakov@mm-sol.com> (Georgi
 Djakov's message of "Tue, 30 Jul 2013 19:22:35 +0300")
References: <1375201355-26906-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <86y58orogf.fsf@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

On Tue, Jul 30 2013, Georgi Djakov wrote:
> This platform driver adds the support of Secure Digital Host
> Controller Interface compliant controller in MSM chipsets.
>
> CC: Asutosh Das <asutoshd@codeaurora.org>
> CC: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> CC: Sahitya Tummala <stummala@codeaurora.org>
> CC: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> This is an initial version of the Qualcomm MSM SDHCI driver.
> It is based on the SDHCI code from coreaurora.org with minor
> modifications. The MMC standard DT bindings are used where
> possible. The patch applies to v3.11-rc3.

Is the arch code that will use this driver already in mainline,
or on its way in?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
