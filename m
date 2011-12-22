From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 22 Dec 2011 19:30:28 +0200
Subject: [PATCH v2 0/9] OMAP4: ASoC: Support for PandaBoard family
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <4EF36934.5010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2011 06:38 PM, Peter Ujfalusi wrote:
> Hello,
> 
> the following series will add ASoC support for PandaBoards.
> PandaBoards have different audio routings compared to SDP4430/Blaze boards, but
> the differences not that big to justify a new ASoC machine driver.
> 
> This series is based on the first three patch from the v1 sereis (those, which
> has been applied by Liam).
> 
> Changes since v1:
> As suggested by Mark the platform data, machine driver has been converted to
> process feature flags instead of Board IDs.
> - The ASoC machine driver registers all DAPM widgets. Based on the received
>   configuration it will disable the unused paths
> - PCM for dmic is only created, if the board has digital mic conencted
> - Jack functionality will be only used on boards supporting it
> - Sound card name for SDP4430 has net been changed

Sorry for the resend, I did ment to send another series, but I ended up
in a wrong directory before I run git-send-email.

-- 
P?ter
