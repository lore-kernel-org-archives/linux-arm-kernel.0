From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 18:13:39 +0000
Subject: [PATCH v2 01/16] ASoC: samsung: i2s: Remove unused gpios field
 from struct i2s
In-Reply-To: <1418997336-17777-2-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150106181339.GO2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 02:55:21PM +0100, Sylwester Nawrocki wrote:
> The 'gpios' field in 'struct i2s' is now unused, this change
> seems to be missing in commit 0429ffeff460c4302bd1520e6
> ("ASoC: samsung: Remove obsolete GPIO based DT pinmuxing").

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/69de2bf6/attachment.sig>
