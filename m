From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 25 Jul 2017 13:38:54 +0200
Subject: [PATCH] pwm: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-45-robh@kernel.org>
References: <20170718214339.7774-45-robh@kernel.org>
Message-ID: <20170725113854.GA22355@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-pwm at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> ---
>  drivers/pwm/pwm-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/0870a355/attachment.sig>
