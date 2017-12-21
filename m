From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 16:14:33 +0800
Subject: [PATCH] ARM: dts: colibri/apalis: use correct compatible for RTC
In-Reply-To: <20171206102929.4755-1-stefan@agner.ch>
References: <20171206102929.4755-1-stefan@agner.ch>
Message-ID: <20171221081432.GM23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 11:29:29AM +0100, Stefan Agner wrote:
> All Toradex Carrier Boards use a st,m41t0 compatible RTC. Compared
> to a st,m41t00 this RTC has also an oscillator fail bit which allows
> to detect when the RTC lost track of time.
> 
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
