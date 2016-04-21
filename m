From: broonie@kernel.org (Mark Brown)
Date: Thu, 21 Apr 2016 16:57:53 +0100
Subject: [PATCH 09/18] ASoC: sti: Update DT example to match the driver
 code
In-Reply-To: <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-10-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160421155753.GS3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 12:04:26PM +0100, Peter Griffin wrote:
> uniperiph-id, version and mode are ST specific bindings and
> need the 'st,' prefix. Update the examples, as otherwise copying
> them yields a runtime error parsing the DT node.

I'm not sure what connection this or the other ASoC documentation update
have to the rest of the series?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/fa1fa204/attachment.sig>
