From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 16:05:43 +0100
Subject: [PATCH 1/2] ARM: mvebu: update v5 defconfig
In-Reply-To: <CACRpkdac7ZZ1MA0QO63SArOWzz-nGuHtKhGyGgyCyFQZYC-m=Q@mail.gmail.com>
References: <1448461036-16724-1-git-send-email-linus.walleij@linaro.org>
 <20151125143954.GD11384@lunn.ch>
 <CACRpkdac7ZZ1MA0QO63SArOWzz-nGuHtKhGyGgyCyFQZYC-m=Q@mail.gmail.com>
Message-ID: <20151125150543.GH11384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The rest I think are selected anyway so that is why they're not
> in the reduced defconfigs.

I'm pretty sure that DSA now require SWITCHDEV be enabled.

    Andrew
