From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Oct 2018 17:51:00 -0300
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4
In-Reply-To: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
References: <1538663639-3427-1-git-send-email-kueffner.markus@gmail.com>
Message-ID: <CAOMZO5BqL5Tfd0+KmN2DiJdoWLSYWSWyppw8qdrb-G_by_68Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 11:35 AM Markus Kueffner
<kueffner.markus@gmail.com> wrote:
>
> From: Markus Kueffner <kueffner.markus@gmail.com>
>
> Add Pincfgs for UART4 to enable Communication with the onboard SAM3X
>
> Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>

Looks good as per the schematics:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

> +&uart4 { // iMX6-Arduino internal serial port - ttymxc3

Minor nit: // style comment should be avoided.

Actually the whole comment could de dropped IMHO.
