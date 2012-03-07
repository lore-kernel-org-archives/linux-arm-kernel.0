From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Mar 2012 14:57:17 +0000
Subject: [PATCH v2] ARM: pxa: fix regulator related build fail in
 magician_defconfig
In-Reply-To: <4F5774B0.1030209@windriver.com>
References: <1331084814.11802.YahooMailClassic@web29012.mail.ird.yahoo.com>
 <4F5774B0.1030209@windriver.com>
Message-ID: <20120307145717.GN3107@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 09:46:08AM -0500, Paul Gortmaker wrote:

> Thanks for the report.  The regulator code is rather foreign
> to me, but I think I figured out the expectations on the names
> last night when looking at a similar patch here:

All it's looking for is the output of dev_name() for the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/54328836/attachment.sig>
