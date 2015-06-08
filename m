From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jun 2015 19:11:37 +0100
Subject: [PATCH 2/8] regulator: pwm-regulator: Remove unnecessary
 descriptor attribute from ddata
In-Reply-To: <1433529771-24496-3-git-send-email-lee.jones@linaro.org>
References: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
 <1433529771-24496-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20150608181137.GT14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 07:42:45PM +0100, Lee Jones wrote:
> The Regulator Device keeps a full copy of it's own, which can be easily accessed.

Applied, thanks.  Please keep your commit logs under 80 columns.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150608/59cef120/attachment.sig>
