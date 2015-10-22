From: davem@davemloft.net (David Miller)
Date: Wed, 21 Oct 2015 19:48:26 -0700 (PDT)
Subject: [PATCH resend] net: sun4i-emac: Properly free resources on
 probe failure and remove
In-Reply-To: <1445330544-6968-2-git-send-email-hdegoede@redhat.com>
References: <1445330544-6968-1-git-send-email-hdegoede@redhat.com>
 <1445330544-6968-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20151021.194826.782971305803462043.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 20 Oct 2015 10:42:24 +0200

> Fix sun4i-emac not releasing the following resources:
> -iomapped memory not released on probe-failure nor on remove
> -clock not getting disabled on probe-failure nor on remove
> -sram not being released on remove
> 
> And while at it also add error checking to the clk_prepare_enable call
> done on probe.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied.
