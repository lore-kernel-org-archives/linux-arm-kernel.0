From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Fri, 30 Dec 2016 16:14:28 +0100
Subject: [PATCH v2 1/6] ARM: mach-mx31_3ds: Remove camera support
In-Reply-To: <1483097613-21481-1-git-send-email-festevam@gmail.com>
References: <1483097613-21481-1-git-send-email-festevam@gmail.com>
Message-ID: <CAM=E1R71EYzGOxfDVVpXJ1gP-EUZ=mxn60-_PAh9diHhw1thvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 December 2016 at 12:33, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
> mx3 driver") the mx3 camera driver has been removed, so remove the camera
> support from the board file as well.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Also remove CSI pins from IOMUX definition

v2 also runs nicely on the i.MX31 PDK hardware.

/Magnus
