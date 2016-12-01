From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 1 Dec 2016 23:36:15 +0100
Subject: [PATCH v7 1/4] i2c: pxa: Add definition of fast and high speed
 modes via the regs layout
In-Reply-To: <20161201110440.27530-2-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
 <20161201110440.27530-2-romain.perier@free-electrons.com>
Message-ID: <20161201223615.GB19261@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 12:04:37PM +0100, Romain Perier wrote:
> So far, the bit masks for the fast and high speed mode were statically
> defined. Some IP blocks might use different bits for these modes.
> 
> This commit introduces new fields in order to enable the definition of
> different bit masks for these features. If these fields are undefined,
> ICR_FM and ICR_HS are selected to preserve backward compatibility with
> other IPs.
> 
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/a419650d/attachment.sig>
