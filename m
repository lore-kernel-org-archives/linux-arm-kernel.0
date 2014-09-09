From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 9 Sep 2014 18:34:15 +0200
Subject: [RFC 2/4] i2c: slave: add eeprom simulator driver
In-Reply-To: <1410274470-12712-3-git-send-email-wsa@the-dreams.de>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-3-git-send-email-wsa@the-dreams.de>
Message-ID: <20140909163415.GA1781@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +config I2C_SLAVE_EEPROM
> +	bool "I2C eeprom slave driver"

This should be "tristate". Fixed in my branch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/ed06cf80/attachment.sig>
