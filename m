From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 15 Nov 2013 23:52:34 +0100
Subject: [PATCH v2 0/5] Add-Broadcom-Kona-I2C-Support
In-Reply-To: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
References: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131115225234.GC2672@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 01:02:11PM -0800, Tim Kryger wrote:
> This series adds support for the Kona I2C bus found on Broadcom mobile
> SoCs like the bcm11351 (aka bcm281xx) and enables it on the bcm28155-ap
> board.
> 
> It depends upon the following commit:
>   http://lkml.indiana.edu/hypermail/linux/kernel/1311.1/03583.html

Fixed Kconfig sorting, squashed broken out patches 1-3 into one and
applied to for-next, thanks! Let me know if I should take patches 4-5
also, but usually they go via arm-soc. Also, please provide a "Changes
since V1" log which will speed up reviewing.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131115/9aa11b15/attachment.sig>
