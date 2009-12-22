From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 22 Dec 2009 09:53:22 +0300
Subject: [PATCH 9/10] ARM: PNX4008: convert i2c-pnx to use clk API
	enable/disable calls
In-Reply-To: <083DF309106F364B939360100EC290F804F592E909@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F592E909@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <acd2a5930912212253q557401d8x39b4e80d9db58b61@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:23 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>



> ---
>  arch/arm/mach-pnx4008/clock.c |   12 ++++++------
>  drivers/i2c/busses/i2c-pnx.c  |   18 +++++++++---------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091222/6ba75dae/attachment-0001.htm>
