From: oskar@scara.com (Oskar Schirmer)
Date: 27 Mar 2012 08:24:19 +0000
Subject: [PATCH v4 4/4] mfd: mc13xxx: Add i2c driver
In-Reply-To: <1332129838-7080-5-git-send-email-marc@cpdesign.com.au>
References: <1332129838-7080-1-git-send-email-marc@cpdesign.com.au>
 <1332129838-7080-5-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120327082419.GA5080@curry>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test against Linux 3.3 fails as crucial patches in regmap core
are not yet mainline. However, with commit cc374fbf5305 from
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
applied, this series works fine.

Signed-off-by: Oskar Schirmer <oskar@scara.com>

On Mon, Mar 19, 2012 at 15:03:58 +1100, Marc Reilly wrote:
> Adds support for mc13xxx family ICs connected via i2c.
> 
> Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
> ---
>  drivers/mfd/Kconfig       |    8 +++-
>  drivers/mfd/Makefile      |    1 +
>  drivers/mfd/mc13xxx-i2c.c |  128 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/mfd/mc13xxx-i2c.c
[...]
