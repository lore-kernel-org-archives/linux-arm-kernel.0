From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 19 Aug 2014 00:24:37 +0400
Subject: [PATCH RESEND v2 7/7] ARM: dts: vf610-twr: Add USB support
In-Reply-To: <07491836b9c23a82b7a33972a5c71f2676ceaf71.1408391385.git.stefan@agner.ch>
References: <cover.1408391385.git.stefan@agner.ch>
 <07491836b9c23a82b7a33972a5c71f2676ceaf71.1408391385.git.stefan@agner.ch>
Message-ID: <53F26105.9000907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/19/2014 12:07 AM, Stefan Agner wrote:

> Add USB support for Freescale Vybrid tower. The USB hosts over-current
> protection signal is not connected is not connected to the PHY's over-

    Yes, we all understood that it's not connected, no need to repeat. ;-)

> current protection, hence we need to disable it.

> Signed-off-by: Stefan Agner <stefan@agner.ch>

WBR, Sergei
