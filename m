From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Sep 2017 15:52:22 -0500
Subject: [PATCH 1/3] RTC: rv3029: fix vendor string
In-Reply-To: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170920205222.u445mraruddz3ufl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 04:00:02AM +0200, Alexandre Belloni wrote:
> The vendor string for Microcrystal is microcrystal.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 2 +-
>  drivers/rtc/rtc-rv3029c2.c                            | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
