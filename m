From: matthew.leach@arm.com (Matthew Leach)
Date: Tue, 4 Sep 2012 12:06:27 +0100
Subject: [PATCH v3] serial: pl011: honour serial aliases in device tree
In-Reply-To: <1346168488-9309-1-git-send-email-matthew.leach@arm.com>
References: <1346168488-9309-1-git-send-email-matthew.leach@arm.com>
Message-ID: <000001cd8a8d$54bbad60$fe330820$@leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan,

> If the order of UART nodes is changed in the device tree, then tty dev
> devices are attached to different serial ports causing the console to
> be directed to a different physical serial port. The "serial" aliases
> in the device tree should prevent this.

Are you okay merging this patch?

Thanks,
Matt
