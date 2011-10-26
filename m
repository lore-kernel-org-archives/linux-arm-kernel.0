From: Pawel.Moll@arm.com (Pawel Moll)
Date: Wed, 26 Oct 2011 10:54:50 +0100
Subject: [PATCH v3] virtio: Add platform bus driver for memory mapped
	virtio device
In-Reply-To: <871uu0pfag.fsf@rustcorp.com.au>
References: <1317841030-17758-1-git-send-email-pawel.moll@arm.com>
	<1317919843-8343-1-git-send-email-pawel.moll@arm.com>
	<1317921230.28696.102.camel@hornet.cambridge.arm.com>
	<87lisjq6tu.fsf@rustcorp.com.au>
	<1318931075.3146.285.camel@hornet.cambridge.arm.com>
	<87ty75adtb.fsf@rustcorp.com.au>
	<1319219844.5094.16.camel@hornet.cambridge.arm.com>
	<87wrbv15lp.fsf@rustcorp.com.au>
	<1319461560.3668.16.camel@hornet.cambridge.arm.com>
	<871uu0pfag.fsf@rustcorp.com.au>
Message-ID: <1319612222.2878.4.camel@rojo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

> I've applied the corresponding changes to the latest version of the
> virtio pci draft spec (0.9.2).  Please check it's accurate...
>
Just a typo (my fault probably ;-) in the InterruptStatus register
description:
* There is:  "Bit 0 | Use Ring Update"
* Should be: "Bit 0 | Used Ring update"

The rest is just fine.

Thanks!

Pawel

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
