From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Nov 2017 18:04:39 +0000
Subject: [PATCH v4 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
In-Reply-To: <1509720477-18936-6-git-send-email-sudeep.holla@arm.com>
References: <1509720477-18936-1-git-send-email-sudeep.holla@arm.com>
 <1509720477-18936-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <273d655b-b1f2-0788-aa60-3d97b84e7304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 03/11/17 14:47, Sudeep Holla wrote:
> The SCMI specification encompasses various protocols. However, not every
> protocol has to be present on a given platform/implementation as not
> every protocol is relevant for it.
> 
> Furthermore, the platform chooses which protocols it exposes to a given
> agent. The only protocol that must be implemented is the base protocol.
> The base protocol is used by an agent to discover which protocols are
> available to it.
> 
> In order to enumerate the discovered implemented protocols, this patch
> adds support for a separate scmi protocol bus. It also adds mechanism to
> register support for different protocols.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
Extremely sorry to both during merge window, but just wanted to check if
you can spare sometime reviewing these SCMI patches. I know it's too
early for v4.16 but with holiday period ahead, thought of checking so
that I won't miss v4.16

-- 
Regards,
Sudeep
