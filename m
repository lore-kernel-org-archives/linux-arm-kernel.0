From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 20:41:33 +0000
Subject: [PATCH v3 04/25] dt-bindings: sound: qcom: Add bindings for q6afe
In-Reply-To: <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-5-srinivas.kandagatla@linaro.org>
Message-ID: <20180301204133.GP12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:16PM +0000, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +- but must contain the following property:
> +
> +- compatible:
> +- qcom,apr-svc-id
> +- qcom,apr-svc-name
> +- #sound-dai-cells

Property or properties?  It's a bit surprising that both the ID and the
name are mandatory, does the name actually get used for non-diagnostic
reasons?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/cb5aaf8d/attachment-0001.sig>
