From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Oct 2014 08:37:12 -0300
Subject: [PATCH v2 RESEND] serial: mxs-auart: add sysrq support
In-Reply-To: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <CAOMZO5BxR4X69LP8HKHRsVFgmaqwQUv328L6fbu4ZvU-Jp61Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 8:13 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
> When using mxs-auart based console, sometime we need the sysrq function
> to help debugging kernel. The sysrq code is basically there,
> this patch just simply enable it.
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
