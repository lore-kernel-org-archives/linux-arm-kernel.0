From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Jun 2016 09:21:06 -0500
Subject: [PATCH 1/5] Documentation: dt: socfpga: Add interrupt-controller
 to ecc-manager
In-Reply-To: <1464193783-5071-2-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
 <1464193783-5071-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160601142106.GA15134@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 11:29:39AM -0500, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Designate the ECC Manager as an interrupt controller and add child
> interrupts.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
>  .../bindings/arm/altera/socfpga-eccmgr.txt         |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
