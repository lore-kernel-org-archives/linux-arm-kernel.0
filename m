From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 21:46:35 +0200
Subject: [PATCH v2 0/4]  arm: tegra: implement NVEC driver using tegra i2c.
In-Reply-To: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
Message-ID: <20150403194635.GC2016@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:00:11PM +0300, Andrey Danin wrote:
> NVEC driver contains code to manage tegra i2c controller in slave mode.
> I2C slave support was implemented in linux kernel. The goal of this
> patch serie is to implement I2C slave mode in tegra drived and rework
> NVEC driver to use it.

Thanks. Looks pretty good already. If being I2C slave was the reason for
this driver being in staging, we soon need to think of a proper place
outside staging.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/88f11028/attachment.sig>
