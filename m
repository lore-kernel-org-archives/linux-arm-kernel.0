From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 7 Mar 2015 04:00:17 +0100
Subject: [PATCH v2 07/10] drivers: PL011: move cts_event workaround into
 separate function
In-Reply-To: <1425491994-23913-8-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
 <1425491994-23913-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20150307030017.GA29063@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 05:59:51PM +0000, Andre Przywara wrote:
> To avoid lines with more than 80 characters and to make the
> pl011_int() function more readable, move the workaround out into a
> separate function.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Conflicts:
> 
> 	drivers/tty/serial/amba-pl011.c

Why is this here in the changelog?  It doesn't make sense when sending
patches out :)

Please fix up and resend the patches I didn't apply.

thanks,

greg k-h
