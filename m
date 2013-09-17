From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Sep 2013 23:03:23 +0100
Subject: [PATCH] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <1379455187-5812-1-git-send-email-csd@broadcom.com>
References: <1379455187-5812-1-git-send-email-csd@broadcom.com>
Message-ID: <20130917220323.GS12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 02:59:47PM -0700, Christian Daudt wrote:
> This patch adds low level debug uart support to Broadcom
>  mobile based SOCs.
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: James King <jamesk@broadcom.com>

Unfortunately, your patch is out of date.

Please have a look at v3.12-rc1's debugging infrastructure.  You should
not need to add any .S file(s) for 8250 based ports, and in fact,
8250_32.S is gone.  It's now all done through Kconfig for these ports.

Thanks.
