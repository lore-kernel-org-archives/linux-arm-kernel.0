From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Oct 2015 16:15:14 +0100
Subject: [RFC PATCH v3 2/4] drm/imx: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1445267270-23126-3-git-send-email-Liviu.Dudau@arm.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20151019151514.GH32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 04:07:48PM +0100, Liviu Dudau wrote:
> The generic function is functionally equivalent to the driver's
> imx_drm_platform_probe(). Use the generic function and reduce the
> overall code size.

Looks fine, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
