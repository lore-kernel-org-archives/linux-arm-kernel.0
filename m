From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Apr 2016 16:01:31 +0100
Subject: [PATCH v1 1/2] amba: Defer device peripheral ID read
In-Reply-To: <1460386716-23262-1-git-send-email-georgi.djakov@linaro.org>
References: <1460386716-23262-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <20160411150130.GL19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 05:58:35PM +0300, Georgi Djakov wrote:
> From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
> 
> To be able to read peripheral ID during device create time
> bus code have turn on device interface clock, but this
> clock could be unavailable at this time. Fix this by defer
> device ID read until driver match time.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Can't do this.  See comments on previous similar patches trying to do the
very same thing.  (Sorry, I don't have time to provide a fuller reply,
especially given that there's already a fuller reply in the last two
months of mailing list archives.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
