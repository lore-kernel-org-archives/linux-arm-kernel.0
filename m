From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 12 Mar 2014 08:26:47 +0100
Subject: [PATCH v3] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
References: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <20140312072647.GC2756@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 12:25:38AM -0400, Marek Roszko wrote:
> This adds the ability to set "clock-frequency" in the device tree for the at91
> i2cbus following the naming of other i2c bus implementations. If the property
> is not set,the clock frequency will default to the previously used define 
> of 100KHz.
> 
> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/9ee92f0f/attachment-0001.sig>
