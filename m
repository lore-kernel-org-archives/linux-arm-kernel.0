From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Oct 2014 16:53:08 -0700
Subject: [PATCHv4 1/3] ARM: dts: socfpga: rename gpio nodes
In-Reply-To: <1414004860-17645-2-git-send-email-dinguyen@opensource.altera.com>
References: <1414004860-17645-1-git-send-email-dinguyen@opensource.altera.com>
 <1414004860-17645-2-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <CAD=FV=X_TQzL=MSJryy05oCs5LL0-_eUeL31BvnxhFa-TGX6BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Wed, Oct 22, 2014 at 12:07 PM,  <dinguyen@opensource.altera.com> wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> Since the Synopsys GPIO IP can support multiple ports of varying widths, it
> would make more sense to have the GPIO node DTS entry as this:
>
> gpio0: gpio at ff708000{
>         porta{
>         };
> };
>
> Also, this is documented in the snps-dwapb-gpio.txt.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

For this one patch the card detect is even more broken than it already
was, but I guess that's OK.  If it's not you could probably just
squash this patch with the next.

Reviewed-by: Doug Anderson <dianders@chromium.org>
