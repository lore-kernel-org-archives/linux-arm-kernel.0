From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 17:14:31 -0500
Subject: [PATCH 3/4] Documentation: dt: usb: atmel-usb: add unit-address
In-Reply-To: <1468364850-32475-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468364850-32475-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160716221431.GA7678@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 01:07:29AM +0200, Alexandre Belloni wrote:
> The endpoint nodes have a reg property, they also need a unit-address. Add
> them in the example.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
