From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 16:18:22 -0600
Subject: [PATCH v4 02/20] dt-bindings: arm: add support for ARM System
 Control and Management Interface(SCMI) protocol
In-Reply-To: <1509720477-18936-3-git-send-email-sudeep.holla@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20171106221822.b6ejvckapvprfsmh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 02:47:39PM +0000, Sudeep Holla wrote:
> This patch adds devicetree binding for System Control and Management
> Interface (SCMI) Message Protocol used between the Application Cores(AP)
> and the System Control Processor(SCP). The MHU peripheral provides a
> mechanism for inter-processor communication between SCP's M3 processor
> and AP.
> 
> SCP offers control and management of the core/cluster power states,
> various power domain DVFS including the core/cluster, certain system
> clocks configuration, thermal sensors and many others.
> 
> SCMI protocol is developed as better replacement to the existing SCPI
> which is not flexible and easily extensible.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 179 +++++++++++++++++++++
>  MAINTAINERS                                        |   4 +-
>  2 files changed, 181 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt

Acked-by: Rob Herring <robh@kernel.org>
