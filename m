From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 24 Jul 2012 20:21:25 +0100
Subject: [alsa-devel] [PATCH 0/4] ASoC: fix saif record unwork issue
In-Reply-To: <500E992E.6090900@bluegiga.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
Message-ID: <20120724192125.GF3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 03:46:38PM +0300, Lauri Hintsala wrote:

> 1. Recorded audio file is totally silent. Hexdump shows zeros.

This one is commonly due to devices powering up muted by default and
requiring that you set some controls to route the audio through - are
you sure you've not missed anything there?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120724/104fec44/attachment-0001.sig>
