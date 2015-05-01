From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 May 2015 17:54:05 +0100
Subject: [PATCH 4/4] ASoC: samsung: Constify platform_device_id
In-Reply-To: <1430496014-32309-4-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430496014-32309-4-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150501165405.GP22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 01:00:14AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150501/34d2749a/attachment-0001.sig>
