From: joel@jms.id.au (Joel Stanley)
Date: Fri, 14 Sep 2018 08:19:34 +0930
Subject: [PATCH] ARM: dts: aspeed: Fix I2C bus warnings
In-Reply-To: <20180913181245.25484-3-robh@kernel.org>
References: <20180913181245.25484-3-robh@kernel.org>
Message-ID: <CACPK8XcqwW93OU88UvovuzXG1h=u9y1708axdABhX+WruKnrOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2018 at 03:42, Rob Herring <robh@kernel.org> wrote:
>
> dtc has new checks for I2C buses. The ASpeed dts files have a node named
> 'i2c' which causes a false positive warning. As the node is a 'simple-bus',
> correct the node name to be 'bus' to fix the warnings.

> ---
> Please apply to the sub-arch tree. The dtc changes haven't landed, but
> will for 4.20.

Applied to aspeed's dt-for-v4.20.

Thanks Rob.
