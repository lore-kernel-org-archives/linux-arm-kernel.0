From: alexg@meprolight.com (Alex Gershgorin)
Date: Sun, 1 Apr 2012 14:12:32 +0300
Subject: mc13xxx: add I2C support, V5
In-Reply-To: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
References: <1333262499-25871-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD2A@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, thanks for V5.

> This series (against mfd-2.6/for-next) changes the mc13xxx driver to use
> regmap and adds I2C support.
> It has a compile dependency on regmap/for-next, as the spi driver uses the
> recently added pad_bits config field.

If included in your plans to relocate the current version of patches for version 3.4?

Cheers,
Alex
