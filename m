From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 01 Dec 2014 11:14:01 -0700
Subject: [PATCH 7/9] ARM: tegra: remove old LIC support
In-Reply-To: <1417195613-8447-8-git-send-email-marc.zyngier@arm.com>
References: <1417195613-8447-1-git-send-email-marc.zyngier@arm.com>
 <1417195613-8447-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <547CAFE9.6010904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2014 10:26 AM, Marc Zyngier wrote:
> Now that all DTs have been updated, entierely drop support for
> the non-DT code.
>
> This is likely to break platforms that do not update their DT,
> so print a warning at boot time.

That seems to imply that yet again we're ignoring DT-is-an-ABI...
