From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 20 Dec 2017 08:27:50 +0800
Subject: [PATCH v4 1/3] dt-bindings: mailbox: Introduce Hi3660 controller
 binding
In-Reply-To: <20171219233038.mjkqakshn7ud7ise@rob-hp-laptop>
References: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
 <1513682145-19892-2-git-send-email-zhongkaihua@huawei.com>
 <20171219233038.mjkqakshn7ud7ise@rob-hp-laptop>
Message-ID: <20171220002747.GA10511@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 05:30:38PM -0600, Rob Herring wrote:
> On Tue, Dec 19, 2017 at 07:15:43PM +0800, Kaihua Zhong wrote:
> > From: Leo Yan <leo.yan@linaro.org>
> > 
> > Introduce a binding for the Hi3660 mailbox controller, the mailbox is
> > used within application processor (AP), communication processor (CP),
> > HIFI and MCU, etc.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../bindings/mailbox/hisilicon,hi3660-mailbox.txt  | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
> 
> Please add acks when posting new versions.

Thanks, Rob.

This is my bad :) and will add acks in later version.

Thanks,
Leo Yan
