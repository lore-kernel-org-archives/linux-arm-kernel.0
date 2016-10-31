From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 23:31:29 -0500
Subject: [PATCH 1/2] DT: binding: bcm2835-mbox: fix address typo in example
In-Reply-To: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
References: <1477505640-26658-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20161031043129.jotjvcxmtmpzn33d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 26, 2016 at 06:13:59PM +0000, Stefan Wahren wrote:
> The address of the mailbox node in the example has a typo.
> So fix it accordingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: d4b5c782b9f4 ("dt/bindings: Add binding for the BCM2835 mailbox driver")
> ---
>  .../bindings/mailbox/brcm,bcm2835-mbox.txt         |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
