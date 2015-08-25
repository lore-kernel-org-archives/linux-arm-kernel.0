From: davem@davemloft.net (David Miller)
Date: Tue, 25 Aug 2015 13:49:12 -0700 (PDT)
Subject: [PATCH] net: sun4i-emac: Claim emac sram
In-Reply-To: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
References: <1440354698-11144-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150825.134912.1446921736351472961.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 23 Aug 2015 20:31:38 +0200

> Claim the emac sram ourselves, rather then relying on the bootloader
> having mapped the sram to the emac controller during boot.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to net-next, thanks.
