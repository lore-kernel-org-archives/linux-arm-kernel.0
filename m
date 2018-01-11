From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 11 Jan 2018 14:56:12 +0000
Subject: [PATCH v5 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <1514904162-11201-4-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <63af0db6-4d78-aa86-cf96-1ad33a5ed604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/18 14:42, Sudeep Holla wrote:
> The SCMI is intended to allow OSPM to manage various functions that are
> provided by the hardware platform it is running on, including power and
> performance functions. SCMI provides two levels of abstraction, protocols
> and transports. Protocols define individual groups of system control and
> management messages. A protocol specification describes the messages
> that it supports. Transports describe the method by which protocol
> messages are communicated between agents and the platform.
> 
> This patch adds basic infrastructure to manage the message allocation,
> initialisation, packing/unpacking and shared memory management.
> 

Any chance you could review patches 3-14 ? All the drivers (15-20) are
already acked by the maintainer. I know it's late for v4.16, I want it
to be ready for v4.17 ASAP. It's on the list without much progress for
few months now :(, hence the push. Sorry for the nag.

-- 
Regards,
Sudeep
