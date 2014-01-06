From: olof@lixom.net (Olof Johansson)
Date: Sun, 5 Jan 2014 16:06:10 -0800
Subject: linux-next: manual merge of the imx-mxs tree with the tree
In-Reply-To: <20140106104938.82a53f6d3b4d773607fe7556@canb.auug.org.au>
References: <20140106104938.82a53f6d3b4d773607fe7556@canb.auug.org.au>
Message-ID: <CAOesGMiTjUV78Gw1eKKSsz2Q0ODTk9p8hT_FcX1d0F3gMbX4Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 5, 2014 at 3:49 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Shawn,
>
> Today's linux-next merge of the imx-mxs tree got a conflict in
> arch/arm/boot/dts/imx6q-sabrelite.dts between commit 8f568b496dd9 ("ARM:
> imx: Explicitly pass the active level of the PHY reset") from the arm-soc
> tree and commit e5a5af250568 ("ARM: dts: imx: sabrelite: add Dual
> Lite/Solo support") from the imx-mxs tree.
>
> I fixed it up (just used the latter) and can carry the fix as necessary
> (no action is required).

Thanks Stephen. The offending patch from the arm-soc side has been
dropped, but I didn't push out the new for-next yet. It should be gone
tomorrow. Same for some of the other imx conflicts.


-Olof
