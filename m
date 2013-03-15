From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Mar 2013 22:25:45 +0100
Subject: [PATCH v2 0/2] refactoring for mask_cache
In-Reply-To: <1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <20130315212545.GT21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 15, 2013 at 08:36:13PM +0100, Gerlando Falauto wrote:
> Hi everyone,
> here is a 2-patch set to address the issue found with Orion,
> hoping I understood correctly what Thomas meant.
> Even though I'm also providing changes for mvebu, I only
> tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
> We currently do not have a working 3.6+ configuration for our Kirkwood
> boards (3.6 is apparently where this mvebu gpio driver was introduced),
> so I would be glad if someone could give it a try.

Hi Garlando

Could you describe how to reproduce the issue, so i can test it on
Kirkwood. I have a kirkwood with one GPIO button which i can use for
tests.

Thanks
	Andrew
