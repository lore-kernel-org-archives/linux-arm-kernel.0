From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2011 21:47:58 -0300
Subject: [PATCH resend] ARM: mx51_efika: fix build error due to new mfd
	changes
In-Reply-To: <20110328172230.01756522@queued.net>
References: <20110328172230.01756522@queued.net>
Message-ID: <AANLkTikLK+jbVhnrNVinhLDXZoozH-6VsjwjYLNwTdxU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andres,

On Mon, Mar 28, 2011 at 9:22 PM, Andres Salomon <dilinger@queued.net> wrote:
>
> MFD changes in 4ec1b54c ('mfd: mfd_cell is now implicitly available
> to mc13xxx drivers') changed the mc13xxx_platform_data struct layout.
> At the time all users were changed, but this driver was introduced in
> another tree at the same time. ?This updates the mc13xxx_platform_data
> user, fixing a build error.
>
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
> ?arch/arm/mach-mx5/mx51_efika.c | ? ?6 ++++--
> ?1 files changed, 4 insertions(+), 2 deletions(-)

Your patch is in Sascha?s tree now:
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commitdiff;h=251290a6078cb88382344b3ee535ae8c6254c1b5

Regards,

Fabio Estevam
