From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Jun 2014 09:19:22 +0200
Subject: [GIT PULL] Allwinner sunXi clock changes for 3.16
In-Reply-To: <20140603174120.10062.16229@quantum>
References: <538B7B6C.3020601@elopez.com.ar>
 <20140603174120.10062.16229@quantum>
Message-ID: <20140604071922.GA5765@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Jun 03, 2014 at 10:41:20AM -0700, Mike Turquette wrote:
> Quoting Emilio L?pez (2014-06-01 12:13:48)
> > Hi Mike,
> > 
> > Here is the sunxi clocks pull for 3.16. As you probably saw during the 
> > cycle, this mostly contains improved A31 support and a bit of 
> > housekeeping. Please note that this pull does *not* contain the MMC 
> > clock patches Hans sent, as you merged those yourself on clk-next
> 
> Hi Emilio,
> 
> -rc8 is pretty late for me to take this in under normal circumstances,
> and since the merge window opened early this time I will defer taking
> this pull request in until 3.16-rc1 is released. It'll be one of the
> first things applied to the new clk-next.

I know that Emilio has been pretty late at sending this, but at least
the A31 USB clocks patches is quite important for us, since it would
allow to add the A31 to Olof's boot test farm.

Could you reconsider merging this?

Just so that doesn't happen again, when do you expect the pull
requests?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/6d0fcfd5/attachment.sig>
