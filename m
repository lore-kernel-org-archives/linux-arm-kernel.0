From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 14 Jun 2013 02:38:41 +0000 (UTC)
Subject: [PATCH] ARM: OMAP3EVM: Marking omap3_evm_display_init() with
 CONFIG_BROKEN
In-Reply-To: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
References: <1371120838-29599-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <alpine.DEB.2.02.1306140238270.5514@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jun 2013, Lokesh Vutla wrote:

> On 37xx EVM non-dt boot fails with current mainline,
> because of broken GPIO numbering in the board file
> that uses hardcoded GPIOs.
> 
> So marking omap3_evm_display_init() with CONFIG_BROKEN
> for now as suggested by Tony as per the below link:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg90399.html
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com> ---

Tested-by: Paul Walmsley <paul@pwsan.com>

- Paul
