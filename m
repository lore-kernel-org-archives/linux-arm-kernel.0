From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Feb 2018 23:09:36 -0200
Subject: [PATCH V2] tty: serial: imx: allow breaks to be received when
 using dma
In-Reply-To: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
References: <20180209212240.14095-1-troy.kisky@boundarydevices.com>
Message-ID: <CAOMZO5AcM7wakoLLKvYb93LJ2iDgnvq66agd9ARwA4QMqmeJbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Fri, Feb 9, 2018 at 7:22 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> This allows me to login after sending a break when service
> serial-getty at ttymxc0.service is running

Please improve the commit log by explaining why this patch fixes the issue.

Thanks
