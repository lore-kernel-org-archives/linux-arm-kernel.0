From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 19 Mar 2014 13:31:25 +0100
Subject: [PATCH v4 2/3] ARM: berlin2q: add the Marvell Armada 1500 pro
 in the documentation
In-Reply-To: <1395153167-21029-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1395153167-21029-1-git-send-email-antoine.tenart@free-electrons.com>
 <1395153167-21029-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53298E1D.1060606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 03:32 PM, Antoine T?nart wrote:
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   Documentation/arm/Marvell/README                         | 5 +++++

Applied to berlin/soc.

>   Documentation/devicetree/bindings/arm/marvell,berlin.txt | 1 +

Squashed into previous patch.

In the future, please keep dts/binding doc changes strictly
separated from other changes. This is not a big deal, so I took
care of it myself (I haven't been clear anyway).

Sebastian
