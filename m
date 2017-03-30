From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 30 Mar 2017 17:05:57 +0200
Subject: [PATCH v4 0/6] initialize dtsi file and dts file for RK3328 SoCs
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Message-ID: <20170330150557.znttalrsxpnmccx6@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 05:40:45PM +0800, cl at rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> Changes in v4:
>     Remove some assigned-clocks as they should be inited in their
>     respective device nodes.
> 
> Changes in v3:
>     Adjust some descriptions in dtsi.
> 
> Changes in v2:
>     Remove RK_FUNC_* in dtsi as it dose not help understand things better.
>     Adjust the order of description in dt-bindings.
> 
> v1:
> These patchs depend on pinctrl patchs as below:

Why didn't you renumber the patches? I and probably others wondered
where and what patch 2 is and why it could be missing. I recall now that
I applied it already. Other maintainers don't have that knowledge. Also,
since I applied your patch, no need for me or the i2c-list to be on CC.

Please no "quick fixes" when sending out patch series. I know it is
tempting but it usually creates confusion.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170330/a5c34961/attachment.sig>
