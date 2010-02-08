From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2010 13:51:24 +0000
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <20100208135124.GA26608@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 07:11:50PM +0530, Rabin Vincent wrote:
> Enable/disable hardware flow control as requested by the termios.
