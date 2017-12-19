From: robh@kernel.org (Rob Herring)
Date: Tue, 19 Dec 2017 17:30:38 -0600
Subject: [PATCH v4 1/3] dt-bindings: mailbox: Introduce Hi3660 controller
 binding
In-Reply-To: <1513682145-19892-2-git-send-email-zhongkaihua@huawei.com>
References: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
 <1513682145-19892-2-git-send-email-zhongkaihua@huawei.com>
Message-ID: <20171219233038.mjkqakshn7ud7ise@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 07:15:43PM +0800, Kaihua Zhong wrote:
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

Please add acks when posting new versions.
