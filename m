From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Nov 2013 21:56:09 -0800
Subject: [PATCH] ARM: bcm2835: add missing #xxx-cells to I2C nodes
In-Reply-To: <1385436942-6283-1-git-send-email-swarren@wwwdotorg.org>
References: <1385436942-6283-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131126055609.GA23716@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 08:35:42PM -0700, Stephen Warren wrote:
> The I2C controller node needs #address-cells and #size-cells properties,
> but these are currently missing. Add them. This allows child nodes to be
> parsed correctly.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This is a patch for 3.13-rc.

Applied.

-Olof
