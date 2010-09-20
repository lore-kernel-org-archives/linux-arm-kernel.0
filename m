From: mail@pawelmoll.com (Pawel Moll)
Date: Mon, 20 Sep 2010 12:31:35 +0100
Subject: [RFC] mmaping with VIVT cache
In-Reply-To: <20100920105019.GB30793@n2100.arm.linux.org.uk>
References: <589851.42712.qm@web120206.mail.ne1.yahoo.com>
	<20100917210649.GA18343@n2100.arm.linux.org.uk>
	<a4e3b92bbd5f9f04fa06dd5d3f2f160a@cox.rootnode.net>
	<20100920105019.GB30793@n2100.arm.linux.org.uk>
Message-ID: <289feaf81f35dca3b83a210929832c5b@cox.rootnode.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> pgprot_noncached will be unsafe on ARMv6 and ARMv7 architectures when
> used for mapping existing memory, as you'll be violating an architectural
> restriction (having aliasing mappings of memory as 'Strongly ordered'
> when there is a pre-existing 'Memory' type mapping.)
> adead.org/mailman/listinfo/linux-arm-kernel

Oh, I'm not concerned about it - it was a custom hack in order to get a
"sh-customer" running. I've just mentioned it as an example that the
problem is real and encountered by different people in different
places...

Pawe?
