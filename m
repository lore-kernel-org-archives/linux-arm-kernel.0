From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Aug 2013 07:09:17 -0500
Subject: [PATCH v6 2/4] drivers: of: add function to scan fdt nodes given
 by path
In-Reply-To: <1376924669-28873-3-git-send-email-m.szyprowski@samsung.com>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <1376924669-28873-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAL_JsqLVi0Nku1Qfui0c-Sst47wBQeKQOW2qjKXg8h4QthYH7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 10:04 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Add a function to scan the flattened device-tree starting from the
> node given by the path. It is used to extract information (like reserved
> memory), which is required on early boot before we can unflatten the tree.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>

Reviewed-by: Rob Herring <rob.herring@calxeda.com>
