From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 12:19:09 -0600
Subject: [PATCH v5 2/9] staging: dwc2: update DT binding to add generic
 clock/phy properties
In-Reply-To: <1386854770-2173-3-git-send-email-mporter@linaro.org>
References: <1386854770-2173-1-git-send-email-mporter@linaro.org>
 <1386854770-2173-3-git-send-email-mporter@linaro.org>
Message-ID: <20131212181909.GJ1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 08:26:03AM -0500, Matt Porter wrote:
> dwc2/s3c-hsotg require a single clock to be specified and optionally
> a generic phy. On the s3c-hsotg driver old style USB phy support is
> present as a fallback so the generic phy properties are optional.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Here I need Acked-by from any of the DT folks. It's pretty obvious
patch, so I woudln't expect to have any issues.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/38241767/attachment-0001.sig>
