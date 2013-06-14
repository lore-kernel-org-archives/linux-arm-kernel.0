From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Jun 2013 17:23:21 +0200
Subject: [PATCH 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if
 clock-frequency is not provided
In-Reply-To: <1370620140-17177-3-git-send-email-gregory.clement@free-electrons.com>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
 <1370620140-17177-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130614152321.GE2929@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:49:00PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb@semihalf.com>
> 
> This commit adds checking whether clock-frequency property acquisition
> has succeeded. Do not waste time to find baud factors if there is no
> information about the desired bus frequency in dts.
> 
> [gregory.clement at free-electrons.com: Reword the commit log]
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>

Please run checkpatch.pl on your patches!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/07f32984/attachment.sig>
