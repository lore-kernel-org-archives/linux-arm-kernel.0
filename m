From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 19:18:27 -0600
Subject: [PATCH v5 5/8] Documentation: bindings: decouple juno specific
 details from generic binding
In-Reply-To: <1478148731-11712-6-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <1478148731-11712-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <20161110011827.pzbiiv47osty4pzf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 10:52:08PM -0600, Sudeep Holla wrote:
> Since SCPI is a generic protocol and the bindings are intended to be
> generic, we need to decouple all the platform specific binding details
> out of the generic bindings.
> 
> This patch moves are the Juno platform specific details into a separate
> binding document.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 20 ++++++-----------
>  .../devicetree/bindings/arm/juno,scpi.txt          | 26 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/juno,scpi.txt

Acked-by: Rob Herring <robh@kernel.org>
