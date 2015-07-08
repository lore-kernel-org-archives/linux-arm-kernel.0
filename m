From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 08 Jul 2015 14:59:22 +0100
Subject: [PATCH v4 1/8] Documentation: add DT binding for ARM System
 Control and Power Interface(SCPI) protocol
In-Reply-To: <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <559D2CBA.10607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 08/06/15 11:39, Sudeep Holla wrote:
> This patch adds devicetree binding for System Control and Power
> Interface (SCPI) Message Protocol used between the Application Cores(AP)
> and the System Control Processor(SCP). The MHU peripheral provides a
> mechanism for inter-processor communication between SCP's M3 processor
> and AP.
>
> SCP offers control and management of the core/cluster power states,
> various power domain DVFS including the core/cluster, certain system
> clocks configuration, thermal sensors and many others.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>

Can you review this version ?

Regards,
Sudeep
