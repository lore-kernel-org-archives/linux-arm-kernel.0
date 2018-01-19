From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Jan 2018 10:03:14 -0200
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <CAOcK=COGi6AmhemVAkGirLoMhMo3Bg4Uy+2bOkK2o7+_dMmTPg@mail.gmail.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
 <84391569-cdb9-1c17-7e37-6fdad954d549@maciej.szmigiero.name>
 <CAOcK=COGi6AmhemVAkGirLoMhMo3Bg4Uy+2bOkK2o7+_dMmTPg@mail.gmail.com>
Message-ID: <CAOMZO5DwTbWh3W7tiLqrvAzqUck0rY78OUt1b6KqZG0tFHEB9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Thu, Jan 18, 2018 at 9:29 PM, Markus Rathgeb <maggu2810@gmail.com> wrote:

> Please let me know if I could add more information or could do some
> further tests etc.

Please test my patch and send your Tested-by tag if it works for you.

It allows to boot fine on my imx6q-udoo board.
