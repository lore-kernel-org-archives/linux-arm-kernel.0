From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 Jun 2014 17:09:02 +0100
Subject: [PATCH 1/5] regulator: act8865: fix parsing of platform data
In-Reply-To: <1403451105-31929-2-git-send-email-b.galvani@gmail.com>
References: <1403451105-31929-1-git-send-email-b.galvani@gmail.com>
 <1403451105-31929-2-git-send-email-b.galvani@gmail.com>
Message-ID: <20140627160902.GR23300@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 05:31:41PM +0200, Beniamino Galvani wrote:
> The driver loops through all available regulators (ACT8865_REG_NUM)
> and accesses pdata->regulators[i].platform_data without checking the
> actual value of num_regulators in platform data, potentially causing a
> invalid memory access.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140627/15ca84b6/attachment.sig>
