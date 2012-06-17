From: olof@lixom.net (Olof Johansson)
Date: Sun, 17 Jun 2012 10:52:33 -0700
Subject: [PATCH v2] ARM: iconnect: Remove include of removed
 linux/spi/orion_spi.h
In-Reply-To: <1339148205-29285-1-git-send-email-andrew@lunn.ch>
References: <1339148205-29285-1-git-send-email-andrew@lunn.ch>
Message-ID: <CAOesGMjL2PdvRG12T_fgPkd5ym2d4RjjtNTni1ZihDj=Uiu-Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 8, 2012 at 2:36 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> v3.5-rc1 fails to build when DT and iconnect is enabled because of
> this now none existant include file.
>
> Also remove the other two SPI include files, which are not needed
> with the move to DT.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Looks like I missed this one the first time around, but applied it to
fixes now. Thanks!


-Olof
