From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Nov 2013 12:30:57 +0000
Subject: [PATCH 1/2] regulator: pfuze100: allow misprogrammed ID
In-Reply-To: <1383715045-15341-1-git-send-email-tharvey@gateworks.com>
References: <1383715045-15341-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20131114123057.GO26614@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 09:17:25PM -0800, Tim Harvey wrote:
> prior to week 08 of 2013 Freescale misprogrammed between 1 and 3% of
> PFUZE1000 parts with a ID=0x8 instead of the expected ID=0x0

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/f8d63c59/attachment-0001.sig>
