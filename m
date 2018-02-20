From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Feb 2018 15:25:36 -0300
Subject: [PATCH v3 1/1] tty: serial: imx: allow breaks to be received when
 using dma
In-Reply-To: <20180220182038.4325-1-troy.kisky@boundarydevices.com>
References: <20180220182038.4325-1-troy.kisky@boundarydevices.com>
Message-ID: <CAOMZO5C_dRcoNhe_YWjLmPnkxv0RNkKLmkxXbTGZ6uUh75CRwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 3:20 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> This allows me to login after sending a break when service
> serial-getty at ttymxc0.service is running
>
> The "tty_insert_flip_char(port, 0, TTY_BREAK)" in clear_rx_errors
> fixes this by allowing the higher layers to see a break.
>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Tested-by: Martin Hicks <mort@bork.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
