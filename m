From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Oct 2011 14:00:37 +0100
Subject: [PATCH] ARM: S3C64XX: Enable TCM support
In-Reply-To: <CACRpkdYtH4SCk3o3W84u+pLwzaXnmU1OP7p631bC08QnP2bR9A@mail.gmail.com>
References: <1318242473-19037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CACRpkdYtH4SCk3o3W84u+pLwzaXnmU1OP7p631bC08QnP2bR9A@mail.gmail.com>
Message-ID: <20111010130037.GE3607@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 02:58:30PM +0200, Linus Walleij wrote:
> On Mon, Oct 10, 2011 at 12:27 PM, Mark Brown

> > The S3C64xx CPUs have TCMs so enable the kernel support for it on these
> > systems.

> Cool! How big are they each, i.e. dmesg?

2x8k each of ITCM and DTCM (16k of each total).
