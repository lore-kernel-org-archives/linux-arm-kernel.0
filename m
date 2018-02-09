From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 9 Feb 2018 18:14:54 -0200
Subject: [PATCH 3/3] ARM: dts: phycore-imx6: set buck regulator modes
 explicitly
In-Reply-To: <1518170721-28198-4-git-send-email-chf.fritz@googlemail.com>
References: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
 <1518170721-28198-4-git-send-email-chf.fritz@googlemail.com>
Message-ID: <CAOMZO5BvhsvL332cs6ng4sPLJR9zOonHmRWbuf7otSUm=7CjZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 9, 2018 at 8:05 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> This patch sets initial buck regulator modes explicitly to a state
> this hardware needs.  So a wrong initial mode set by bootloader or
> pmic itself does not interfere anymore.
>
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> Signed-off-by: Christian Hemp <c.hemp@phytec.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
