From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 06 Feb 2015 22:09:36 +0300
Subject: [PATCH 1/1] ARM: dts: Use more descriptive names for Exynos5420
 PDs
In-Reply-To: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1423244258-24314-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54D51170.10903@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/06/2015 08:37 PM, Javier Martinez Canillas wrote:

> All the device nodes for the Exynos5420 power-domains have a quite
> generic "power-domain" name.

    And this is in conformance to the ePAPR standard.

> So in case of an error, the Exynos PD
> driver shows the following (not very useful) message:

> "Power domain power-domain disable failed"

    Why not fix the message instead to use the full device name?

> Use descriptive names to know on which PD enable or disable failed.

> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

WBR, Sergei
