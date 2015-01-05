From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Jan 2015 20:16:38 +0000
Subject: [PATCH] ASoC: adi: Add missing return statement.
In-Reply-To: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
References: <1420042837-3337-1-git-send-email-andrew.jackson@arm.com>
Message-ID: <20150105201638.GN2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 04:20:37PM +0000, Andrew Jackson wrote:
> From: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> The probe routine was disabling the clock even
> if the system was configured successfully.  Add
> a return statement to leave clocks enabled.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/effb3187/attachment-0001.sig>
