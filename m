From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 12 Nov 2014 17:14:22 +0200
Subject: [PATCHv6 1/5] Documentation: dt: add common bindings for
 hwspinlock
In-Reply-To: <1410553499-55951-2-git-send-email-s-anna@ti.com>
References: <1410553499-55951-1-git-send-email-s-anna@ti.com>
 <1410553499-55951-2-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbZqj23J4M8n5FOkPdUOcyK3==TXgc3DfX=LKS6E8C+-Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Fri, Sep 12, 2014 at 11:24 PM, Suman Anna <s-anna@ti.com> wrote:
> This patch adds the generic common bindings used to represent
> a hwlock device and use/request locks in a device-tree build.
>
...
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../devicetree/bindings/hwlock/hwlock.txt          | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/hwlock.txt

Please ask a DT maintainer to ACK this - otherwise I can't send this to Linus.

Thanks,
Ohad.
