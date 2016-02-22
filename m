From: robh@kernel.org (Rob Herring)
Date: Sun, 21 Feb 2016 20:53:37 -0600
Subject: [PATCH v3 2/3] ARM: dts: Change iio_hwmon nodes to use hypen in
 node names
In-Reply-To: <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
References: <cover.1455597464.git.maitysanchayan@gmail.com>
 <c47b13603fe72737ef67ed8b90fc61516cfa2a20.1455597464.git.maitysanchayan@gmail.com>
Message-ID: <20160222025337.GA15973@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:30:54AM +0530, Sanchayan Maity wrote:
> Change iio_hwmon nodes to use hypen in node names instead of
> underscore.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/iio-bindings.txt | 2 +-
>  arch/arm/boot/dts/imx23.dtsi                           | 2 +-
>  arch/arm/boot/dts/imx28.dtsi                           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

No real objection here though I don't think this is really necessary. 
While we prefer '-' to '_' it's not really strong enough to change. It 
bothers me more that the node name leaks to userspace.

Rob
