From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Nov 2017 13:03:20 -0600
Subject: [PATCH v3 1/3] dt-bindings: mailbox: Introduce Hi3660 controller
 binding
In-Reply-To: <1510910672-1409-2-git-send-email-xuyiping@hisilicon.com>
References: <1510910672-1409-1-git-send-email-xuyiping@hisilicon.com>
 <1510910672-1409-2-git-send-email-xuyiping@hisilicon.com>
Message-ID: <20171120190320.vg73gsms7grouieg@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 17, 2017 at 05:24:30PM +0800, Xu YiPing wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> Introduce a binding for the Hi3660 mailbox controller, the mailbox is
> used within application processor (AP), communication processor (CP),
> HIFI and MCU, etc.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt

Acked-by: Rob Herring <robh@kernel.org>
