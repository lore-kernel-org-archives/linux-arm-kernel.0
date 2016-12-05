From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 5 Dec 2016 15:12:00 +0100
Subject: [PATCH 3/3] USB: OHCI: nxp: remove useless extern declaration
In-Reply-To: <1480735523-23950-4-git-send-email-csmanjuvijay@gmail.com>
References: <1480735523-23950-1-git-send-email-csmanjuvijay@gmail.com>
 <1480735523-23950-4-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <20161205141200.GD29165@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 03, 2016 at 03:25:23AM +0000, csmanjuvijay at gmail.com wrote:
> From: Manjunath Goudar <csmanjuvijay@gmail.com>
> 
> Remove usb_disabled() extern declaration as it is already declared
> as EXPORT_SYMBOL_GPL declaration.

merge this with your first patch please, it belongs with it.
