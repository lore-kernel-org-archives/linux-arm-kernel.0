From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Oct 2013 21:19:45 +0000
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <1382992009-19407-1-git-send-email-festevam@gmail.com>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
Message-ID: <20131028211945.GJ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 06:26:49PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> This is based on the initial work done by Sascha Hauer and Tony Prisk.

It looks like you've also taken some of the suggestions I've made too -
like the voltage drive and symbol transmit control settings.

It would be nice to identify the changes a bit better so that those of
us who are testing your drivers (and have patches on top of them to make
things work) know what's changed.
