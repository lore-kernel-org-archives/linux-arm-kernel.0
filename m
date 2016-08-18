From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Aug 2016 14:22:19 -0500
Subject: [PATCH] input: touchscreen: silead: Add regulator support
In-Reply-To: <1471376124-31169-1-git-send-email-hdegoede@redhat.com>
References: <1471376124-31169-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160818192219.GA28941@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 09:35:24PM +0200, Hans de Goede wrote:
> On some tablets the touchscreen controller is powered by seperate
> regulators, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/input/touchscreen/silead.c                 | 51 ++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 4 deletions(-)
