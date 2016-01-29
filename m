From: robh@kernel.org (Rob Herring)
Date: Thu, 28 Jan 2016 20:46:06 -0600
Subject: [PATCH v4 2/3] Documentation: gpio: Update description for
 X-Gene standby GPIO controller DTS binding
In-Reply-To: <1453792935-19916-3-git-send-email-qnguyen@apm.com>
References: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
 <1453792935-19916-3-git-send-email-qnguyen@apm.com>
Message-ID: <20160129024606.GA18663@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 02:22:14PM +0700, Quan Nguyen wrote:
> Update description for X-Gene standby GPIO controller DTS binding to
> support GPIO line configuration as input, output or external IRQ pin.
> 
> Signed-off-by: Y Vo <yvo@apm.com>
> Signed-off-by: Quan Nguyen <qnguyen@apm.com>
> ---
>  .../devicetree/bindings/gpio/gpio-xgene-sb.txt     | 39 ++++++++++++++++++----
>  1 file changed, 33 insertions(+), 6 deletions(-)

Did you change something here? I've already acked this. Please add acks 
when posting new versions.

Rob
