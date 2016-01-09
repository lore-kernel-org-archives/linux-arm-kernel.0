From: robh@kernel.org (Rob Herring)
Date: Sat, 9 Jan 2016 16:28:10 -0600
Subject: [PATCH v3 2/3] Documentation: gpio: Update description for
 X-Gene standby GPIO controller DTS binding
In-Reply-To: <1452162428-26839-3-git-send-email-qnguyen@apm.com>
References: <1452162428-26839-1-git-send-email-qnguyen@apm.com>
 <1452162428-26839-3-git-send-email-qnguyen@apm.com>
Message-ID: <20160109222810.GA11205@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 05:27:07PM +0700, Quan Nguyen wrote:
> Update description for X-Gene standby GPIO controller DTS binding to
> support GPIO line configuration as input, output or external IRQ pin.
> 
> Signed-off-by: Y Vo <yvo@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> ---
>  .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 49 +++++++++++++++++-----
>  1 file changed, 38 insertions(+), 11 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
