From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 30 Nov 2017 09:15:39 +0100
Subject: [RFC 1/2] mailbox: ZynqMP IPI mailbox controller
In-Reply-To: <1511999947-8274-2-git-send-email-jliang@xilinx.com>
References: <1511999947-8274-1-git-send-email-jliang@xilinx.com>
 <1511999947-8274-2-git-send-email-jliang@xilinx.com>
Message-ID: <CAOFm3uGaxxRtjnxU9MbbsEbiJejZ5tkafnZGaWc4wZVczYwKcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 12:59 AM, Wendy Liang <wendy.liang@xilinx.com> wrote:
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> new file mode 100644
> index 0000000..229f26c
> --- /dev/null
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -0,0 +1,633 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

FYI, the style Linus wants us to use is this for .c:, as a top line:

// SPDX-License-Identifier: GPL-2.0


See the threads for details on this.

-- 
Cordially
Philippe Ombredanne
