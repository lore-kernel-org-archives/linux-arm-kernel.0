From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 11:07:24 +0000
Subject: [PATCH v8 3/3] regulator: qcom-rpm: Add missing state flag in
 call to RPM
In-Reply-To: <1417038661-30209-4-git-send-email-bjorn.andersson@sonymobile.com>
References: <1417038661-30209-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1417038661-30209-4-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20141127110724.GJ7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 01:51:01PM -0800, Bjorn Andersson wrote:
> This adds the missing state parameter to the call down to the RPM. This
> is currently hard coded to the active state, as that's all we're
> supporting at this moment.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/6f27398d/attachment.sig>
