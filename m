From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 12:47:00 -0600
Subject: [PATCH v2 4/7] drm/panel: simple: Add support for KEO
 TX31D200VM0BAA
In-Reply-To: <1515046345-15881-5-git-send-email-jagan@amarulasolutions.com>
References: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
 <1515046345-15881-5-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180105184700.tf45evf2ftflth5w@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 11:42:22AM +0530, Jagan Teki wrote:
> This adds support for the Kaohsiung Opto-Electronics.,
> TX31D200VM0BAA 12.3" HSXGA LVDS panel, which can be
> supported by the simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Updated binding info about optional properties, node and example
> 
>  .../bindings/display/panel/koe,tx31d200vm0baa.txt  | 25 ++++++++++++++++++++

Reviewed-by: Rob Herring <robh@kernel.org>                 

>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
