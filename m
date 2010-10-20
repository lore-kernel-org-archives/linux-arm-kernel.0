From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Oct 2010 14:31:38 -0200
Subject: [PATCH] ARM: pcm043 micrell ksz8041nl phy support
In-Reply-To: <201010201757.34531.tstone@iss.tu-darmstadt.de>
References: <201010201757.34531.tstone@iss.tu-darmstadt.de>
Message-ID: <AANLkTikpzT0LtzLBdzmXdBc0CcWJMYVNKMOF1cZe+_SV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Wed, Oct 20, 2010 at 1:57 PM, Tim Sander <tstone@iss.tu-darmstadt.de> wrote:
> Hi
>
> This patch add the missing support for the phy used on the phytec pcm043 boards.
> Please consider for mainline. Tested on pcm043 hardware.
>
> Best regards
> Tim
>
> Signed-off-by: Tim Sander <tim.sander@hbm.com>
>
> ---
> ?drivers/net/fec.c | ? 39 +++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 39 insertions(+), 0 deletions(-)

As your patch touches drivers/net/fec.c you need to copy netdev mailing list.

Regards,

Fabio Estevam
