From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2016 19:49:50 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6q-cm-fx6: fix the operation points
In-Reply-To: <cd3010c3a4144ec38f2cfd1bfbd1b2ad@rwthex-s1-b.rwth-ad.de>
References: <cd3010c3a4144ec38f2cfd1bfbd1b2ad@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5DOCZGiy3vG4U_pKOAxfu7m3UAVMOOox9k6ru+RvaNZSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2016 at 12:19 PM,  <christopher.spinrath@rwth-aachen.de> wrote:

> +&cpu0 {
> +       /* Although the imx6q fuse indicates that 1.2GHz operation is possible,
> +        * the module behaves unstable at this frequency. Hence, remove the
> +        * 1.2GHz operation point here.
> +        */

Just one minor comment.

>From Documentation/CodingStyle:

"The preferred style for long (multi-line) comments is:

    /*
     * This is the preferred style for multi-line
     * comments in the Linux kernel source code.
     * Please use it consistently.
     *
     * Description:  A column of asterisks on the left side,
     * with beginning and ending almost-blank lines.
     */
"

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
