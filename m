From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 26 Sep 2013 15:47:55 -0700
Subject: [PATCH] serial: prepare for 9bit data
In-Reply-To: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
References: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
Message-ID: <20130926224755.GA15399@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 02:07:32PM +0200, Jiri Prchal wrote:
> This patch adds 9bit data possibility for serial_core. Please confirm that I did it right way at right place. I'll make atmel_serial driver for 9bit data later.

Please wrap your lines properly.

I'd rather wait to add this type of patch _after_ you have tested it and
verified that your driver works, and take that patch at the same time.

Otherwise, this is just added cruft that no one is using, and I'd have
to remove it :)

thanks,

greg k-h
