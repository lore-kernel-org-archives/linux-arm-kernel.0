From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 18 Nov 2014 16:19:27 +0100
Subject: [PATCH v3 3/3] ARM: dts: meson: add I2C controller nodes
In-Reply-To: <1415907123-4318-4-git-send-email-b.galvani@gmail.com>
References: <1415907123-4318-1-git-send-email-b.galvani@gmail.com>
 <1415907123-4318-4-git-send-email-b.galvani@gmail.com>
Message-ID: <20141118151927.GG30004@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 08:32:03PM +0100, Beniamino Galvani wrote:
> Add nodes for I2C controllers A,B,AO, which are available in both
> Meson6 and Meson8.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---

I usually don't take DTS patches. They should go via arm-soc. Please say
so if there are reasons I should take it.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/09cfab71/attachment.sig>
