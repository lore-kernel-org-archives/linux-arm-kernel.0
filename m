From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 22 Dec 2009 09:52:50 +0300
Subject: [PATCH 8/10] ARM: PNX4008: move i2c suspend/resume callbacks into
	driver[PATCH] ARM: PNX4008: move i2c clock start/stop into driver
In-Reply-To: <083DF309106F364B939360100EC290F804F592E908@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F592E908@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <acd2a5930912212252k719ed073pbc418d9467ca7941@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:22 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>


> ---
>  arch/arm/mach-pnx4008/i2c.c  |   36 ------------------------------------
>  drivers/i2c/busses/i2c-pnx.c |   39
> ++++++++++++++++++++++++++++++---------
>  include/linux/i2c-pnx.h      |    4 ++--
>  3 files changed, 32 insertions(+), 47 deletions(-)
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091222/c91b0553/attachment-0001.htm>
