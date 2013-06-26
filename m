From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 26 Jun 2013 14:05:04 +0100
Subject: [GIT PULL] GPIO regression fix for omap1 for v3.10-rc
Message-ID: <CACxGe6t8KvnUfm7bt3-8+9d9KXwz1W4dQB+y+m0D75DRkMCGGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

It took a while to work out the correct solution to this regression.
It is sorted now. This branch was constructed and tested by Tony. I've
verified that it builds and signed the tag. Please pull into v3.10.

g.

The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:

  Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)

are available in the git repository at:

  git://git.secretlab.ca/git/linux tags/gpio-for-linus

for you to fetch changes up to 397eada946712b90e0620c378b366bcc6c98c9f6:

  gpio/omap: don't use linear domain mapping for OMAP1 (2013-06-25
23:13:40 -0700)

----------------------------------------------------------------
Fix for omap1 GPIO breaking regression

----------------------------------------------------------------
Javier Martinez Canillas (1):
      gpio/omap: don't use linear domain mapping for OMAP1

 drivers/gpio/gpio-omap.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

On Wed, Jun 26, 2013 at 8:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d:
>
>   Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/gpio-signed
>
> for you to fetch changes up to 397eada946712b90e0620c378b366bcc6c98c9f6:
>
>   gpio/omap: don't use linear domain mapping for OMAP1 (2013-06-25 23:13:40 -0700)
>
> ----------------------------------------------------------------
> Fix for omap1 GPIO breaking regression.
>
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       gpio/omap: don't use linear domain mapping for OMAP1
>
>  drivers/gpio/gpio-omap.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
