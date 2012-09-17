From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 17 Sep 2012 15:17:23 +0200
Subject: [PATCH] ARM: Add config option DEBUG_DECOMPRESS_KERNEL
In-Reply-To: <1347887324-22884-1-git-send-email-mvs@tigris.de>
References: <1347887324-22884-1-git-send-email-mvs@tigris.de>
Message-ID: <20120917131723.GB25899@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 03:08:44PM +0200, Maximilian Schwerin wrote:
> This change allows preventing the message "Uncompressing Linux..." from
> being sent to serial port. This is necessary if the primary serial port is
> used for something other than kernel debugging (e.g. some external device
> controlled by serial commands).

Disabling CONFIG_DEBUG_LL doesn't work?

Regards,
Domenico
