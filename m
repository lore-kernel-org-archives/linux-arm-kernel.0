From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 14:27:20 +0000
Subject: [PATCH 2/2] ARM: vt8500: Add support for UHCI companion controller
In-Reply-To: <1342704684-4858-2-git-send-email-linux@prisktech.co.nz>
References: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>
 <1342704684-4858-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <201207191427.20831.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Tony Prisk wrote:
> Add support for the UHCI companion controller in arch-vt8500.
> This patch is based almost entirely off uhci-grlib.c with
> additions for device tree support.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

It looks like this file is basically completely generic, so could you
just call it uhci-of instead so we can use it for all uhci implementations
that have no special requirements?

	Arnd
