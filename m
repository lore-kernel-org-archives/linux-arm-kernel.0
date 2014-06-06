From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Jun 2014 11:00:05 +0100
Subject: [PATCH 4/5] ARM: atmel: sama5d3xek: switch sound to CCF
In-Reply-To: <1401963572-10953-5-git-send-email-voice.shen@atmel.com>
References: <1401963572-10953-1-git-send-email-voice.shen@atmel.com>
 <1401963572-10953-5-git-send-email-voice.shen@atmel.com>
Message-ID: <20140606100005.GD2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:19:31PM +0800, Bo Shen wrote:
> As the sama5d3xek board has switch to CCF, so add clock for wm8904
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Reviwed-by: Mark Brown <broonie@linaro.org>

The bindings won't change so this is good to go.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140606/aa78dd09/attachment.sig>
