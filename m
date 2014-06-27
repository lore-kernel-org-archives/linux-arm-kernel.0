From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Jun 2014 17:07:25 +0100
Subject: [PATCH 2/5] regulator: act8865: set correct number of regulators
 in pdata
In-Reply-To: <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-3-git-send-email-b.galvani@gmail.com>
Message-ID: <20140627160725.GQ23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 05:31:42PM +0200, Beniamino Galvani wrote:
> When platform data is populated from DT all the regulators are
> instantiated and the value of num_regulators should be the number of
> all available regulators rather than the number of matched ones.

Could you go into more detail on your logic on this one please?  The
platform data (and DT configuration) for regulators should be completely
optional.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/ecfd6ea3/attachment.sig>
