From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 22 Dec 2009 09:50:30 +0300
Subject: [PATCH 5/10] ARM: PNX4008: convert watchdog to use clk API
	enable/disable calls
In-Reply-To: <083DF309106F364B939360100EC290F804F592E905@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F592E905@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <acd2a5930912212250p1b57329bre88542a9a0a86349@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:22 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>


> ---
>  arch/arm/mach-pnx4008/clock.c  |    4 ++--
>  drivers/watchdog/pnx4008_wdt.c |   37
> ++++++++++++++++++++++++-------------
>  2 files changed, 26 insertions(+), 15 deletions(-)
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091222/22ab9cad/attachment-0001.htm>
