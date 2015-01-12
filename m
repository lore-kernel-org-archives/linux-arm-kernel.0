From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 16:35:19 +0100
Subject: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit
 option
In-Reply-To: <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
 <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <3712986.8SuKNvhKTk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 January 2015 21:08:21 Eddie Huang wrote:
> Add earlycon support not only baudrate option, but also add noinit option.
> If use noinit option, 8250 earlycon will not init serial hardware and use
> loader setting.
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

I probably missed something in the previous discussion, but why is
"noinit" not just the default? I believe that is how we handle early
serial ports on PowerPC, and I see no downsides to it.

	Arnd
