From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 25 Nov 2014 15:26:33 +0100
Subject: [PATCH v3] i2c-pxa: add support for SCCB devices
In-Reply-To: <54740E1D.9060508@tul.cz>
References: <54711397.9060601@tul.cz> <20141123083112.GA1932@katana>
 <54725DE2.9090800@tul.cz> <20141124172753.GA25434@katana>
 <54740E1D.9060508@tul.cz>
Message-ID: <20141125142633.GE1843@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 06:05:33AM +0100, Petr Cvek wrote:
> Fixed missing functionality flag I2C_FUNC_NOSTART.
> 
> Added support for SCCB by implementing I2C_M_IGNORE_NAK and I2C_M_STOP flag and belonging functionality flag I2C_FUNC_PROTOCOL_MANGLING.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Applied to for-next, thanks!

Please send new patches as seperate threads, not as a reply to the old
patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/c1709f10/attachment.sig>
