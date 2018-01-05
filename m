From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Jan 2018 12:46:21 -0600
Subject: [PATCH v2 1/7] drm/panel: simple: add support for Ampire
 AM-800480AYTZQW-00H
In-Reply-To: <1515046345-15881-2-git-send-email-jagan@amarulasolutions.com>
References: <1515046345-15881-1-git-send-email-jagan@amarulasolutions.com>
 <1515046345-15881-2-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20180105184621.25m3n7cvkt5prkel@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 11:42:19AM +0530, Jagan Teki wrote:
> This adds support for the Ampire AM-800480AYTZQW-00H 7.0" WGA LCD,
> which can be supported by the simple panel driver.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Updated binding info about optional properties, node and example
> 
>  .../display/panel/ampire,am-800480aytzqw-00h.txt   | 25 ++++++++++++++++++++

Reviewed-by: Rob Herring <robh@kernel.org>                 

>  drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-800480aytzqw-00h.txt
