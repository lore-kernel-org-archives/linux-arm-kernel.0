From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Fri, 7 Mar 2014 21:30:58 +0000
Subject: [PATCH RFC v2 08/11] tty: xuartps: Rename Kconfig symbols
In-Reply-To: <1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1394219614-3197-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394219614-3197-9-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140307213058.702ff194@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Mar 2014 11:13:31 -0800
Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:

> Rename the config symbols for the Cadence UART to reflect the driver
> rebranding:
>   SERIAL_XILINX_PS_UART(_CONSOLE) -> SERIAL_CADENCE_UART(_CONSOLE)

This breaks all those setups people have with pre-packed .config files
that have worked for a long time and now randomly need changing for this
kernel.
