From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:02:19 -0800
Subject: [PATCH] CNS3xxx: Fix PCI cns3xxx_write_config()
In-Reply-To: <m360wtjlmp.fsf@t19.piap.pl>
References: <m360wtjlmp.fsf@t19.piap.pl>
Message-ID: <20160313010219.GG17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 12:32:14PM +0100, Krzysztof Halasa wrote:
> The "where" offset was added twice, fix it.
> 
> Signed-off-by: Krzysztof Ha??asa <khalasa@piap.pl>
> Fixes: 498a92d42596 ("ARM: cns3xxx: pci: avoid potential stack overflow")

Thanks, applied to next/fixes-non-critical.


-Olof
