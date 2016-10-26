From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Oct 2016 16:42:35 -0500
Subject: [PATCH v2 2/9] dt-bindings: interrupt-controller: add DT binding
 for meson GPIO interrupt controller
In-Reply-To: <1476890480-8884-3-git-send-email-jbrunet@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-3-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161026214234.4q6wmecehqh6q32o@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 05:21:13PM +0200, Jerome Brunet wrote:
> 
> This commit adds the device tree bindings description for Amlogic's GPIO
> interrupt controller available on the meson8, meson8b and gxbb SoC families
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> Rob, I did not include the Ack you gave for the RFC as bindings have slightly
> changed. Only the interrupt property has be removed following a discussion I
> had with Marc

As Mark R already said, you should keep the interrupts property.
