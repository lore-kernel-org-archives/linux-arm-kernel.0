From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Feb 2016 13:25:31 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable DW_WATCHDOG
In-Reply-To: <7htwlpb8j2.fsf@baylibre.com>
References: <1454518986-25953-1-git-send-email-dinguyen@opensource.altera.com>
 <7htwlpb8j2.fsf@baylibre.com>
Message-ID: <20160204212531.GA10933@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 04:53:37PM -0800, Kevin Hilman wrote:
> <dinguyen@opensource.altera.com> writes:
> 
> > From: Dinh Nguyen <dinguyen@opensource.altera.com>
> >
> > The watchdog timer on the SoCFPGA platform is the Synopsys Designware watchdog.
> > Enable CONFIG_DW_WATCHDOG for the driver to get built.
> >
> > Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> I confirm that this fixes the boot problems I was seeing on my socfpga
> board.

Thanks, applied to fixes.


-Olof
