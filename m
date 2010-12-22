From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 22 Dec 2010 11:46:04 -0800
Subject: [PATCH v5 1/2] davinci: am18x/da850/omap-l138: add support for
	higher speed grades
In-Reply-To: <1292860894-3961-1-git-send-email-nsekhar@ti.com> (Sekhar Nori's
	message of "Mon, 20 Dec 2010 21:31:33 +0530")
References: <1292860894-3961-1-git-send-email-nsekhar@ti.com>
Message-ID: <8739pptwub.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> AM18x/DA850/OMAP-L138 SoCs have variants that can operate
> at a maximum of 456 MHz at 1.3V operating point. Also the
> 1.2V operating point has a variant that can support a maximum
> of 375 MHz.
>
> This patch adds three new OPPs (456 MHz, 408 MHz and 372 MHz)
> to the list of DA850 OPPs.
>
> Not all silicon is qualified to run at higher speeds and
> unfortunately the maximum speed the chip can support can only
> be determined from the label on the package (not software
> readable).
>
> Because of this, we depend on the maximum speed grade information
> to be provided to us in some board specific way. The board informs
> the maximum speed grade information by setting the da850_max_speed
> variable.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Since v4, the patch decription has been updated to match the code.
> No code change has been made.

Thanks, I updated davinci-next branch with these versions.  Queuing for
2.6.38.

Kevin
