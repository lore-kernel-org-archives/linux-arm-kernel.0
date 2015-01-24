From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 24 Jan 2015 20:06:50 +0000 (UTC)
Subject: [PATCH 17/23] ARM: OMAP4: control: remove support for legacy
 padconf APIs
In-Reply-To: <1417103514-17027-18-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-18-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1501242006180.5450@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Tero Kristo wrote:

> These are no longer needed for anything with the introduction of
> pinctrl DT support, thus removed.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Dropping since Tomi mentioned that the legacy mux support is still in use.


- Paul
