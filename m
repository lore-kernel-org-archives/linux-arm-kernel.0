From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Mar 2017 09:35:15 -0500
Subject: [PATCH V5 1/9] PM / Domains: Ignore domain-idle-states that are
 not compatible
In-Reply-To: <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
 <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <20170312143515.aodwv66ltyznrjj5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 12:41:27PM -0800, Lina Iyer wrote:
> domain-idle-states property may have phandles to idle state bindings
> that may not be compatible with idle state definition defined in [1].
> Such phandles would just be ignored and not throw and error when read by
> the domain core.
> 
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt |  4 +++-
>  drivers/base/power/domain.c                              | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
