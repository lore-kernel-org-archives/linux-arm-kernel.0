From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 15 Nov 2012 15:58:14 +0000
Subject: [PATCH] bindings: i2c: use consistent naming for i2c binding
 descriptions
In-Reply-To: <1352827003-24287-1-git-send-email-wolfram@the-dreams.de>
References: <1352827003-24287-1-git-send-email-wolfram@the-dreams.de>
Message-ID: <20121115155814.30AA83E194B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2012 18:16:43 +0100, Wolfram Sang <wolfram@the-dreams.de> wrote:
> Filenames of devictree binding documentation seems to be arbitrary and
> for me it is unneeded hazzle to find the corresponding documentation for
> a specific driver.
> 
> Naming the description the same as the driver is a lot easier and makes
> sense to me since the driver defines the binding it understands.
> 
> Also, remove a reference in one source to the binding documentation, since path
> information easily gets stale.
> 
> Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks.

g.
