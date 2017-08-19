From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 19 Aug 2017 17:05:18 +0100
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <dc85dbbe-3f2f-8630-3acd-9b11183383c7@gmail.com> (Florian
 Fainelli's message of "Fri, 18 Aug 2017 11:24:28 -0700")
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
 <yw1xfudkodvv.fsf@mansr.com>
 <6f0092f7-692f-4a15-1d95-40f4e59c8585@sigmadesigns.com>
 <yw1xbmo8odan.fsf@mansr.com>
 <3b858e14-0da1-d4aa-eb84-f136ece8c2a6@gmail.com>
 <yw1x4ltzm2ok.fsf@mansr.com>
 <48734beb-0e6b-3a8f-ebf4-b1cec63322e5@gmail.com>
 <fb868111-bcff-9a12-70db-a820d3bbffd0@sigmadesigns.com>
 <ee3119ec-75e9-376d-f1f1-630a9a17c660@arm.com>
 <dc85dbbe-3f2f-8630-3acd-9b11183383c7@gmail.com>
Message-ID: <yw1xinhj8rwh.fsf@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> What do we do with this patch series to move forward? Can we get Doug's
> changes queued up for 4.14?

My opinion is that the correct combined function should be added and the
tango driver updated to use it.  Patches already exist, so what are we
waiting for?

-- 
M?ns Rullg?rd
