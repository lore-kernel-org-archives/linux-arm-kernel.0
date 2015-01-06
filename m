From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jan 2015 18:14:02 +0000
Subject: [PATCH v2 02/16] ASoC: samsung: i2s:
 samsung_i2s_get_driver_data() cleanup
In-Reply-To: <1418997336-17777-3-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20150106181402.GP2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 02:55:22PM +0100, Sylwester Nawrocki wrote:
> Tidy up the samsung_i2s_get_driver_data() function by using
> IS_ENABLE() instead of #ifdef and add missing braces for
> the 'else' part. Also ensure we are not dereferencing NULL
> 'match' pointer.

This doesn't apply against current code, can you please check and
resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/bff240e8/attachment.sig>
