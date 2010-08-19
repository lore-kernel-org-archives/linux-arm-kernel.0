From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 19 Aug 2010 19:04:32 +0200
Subject: ixp4xx support in newer kernels
In-Reply-To: <AANLkTin-A2ubhzsn0DGD2vWn1RxougLV=4V-CS3VcNWe@mail.gmail.com>
	(y. bhanu's message of "Wed, 18 Aug 2010 00:48:34 -0700")
References: <AANLkTin-A2ubhzsn0DGD2vWn1RxougLV=4V-CS3VcNWe@mail.gmail.com>
Message-ID: <m3wrrmr0tb.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

y bhanu <kernelccrazy@gmail.com> writes:

> I am starting off on a new project with ixp4xx based chip.
> I already have it working in 2.6.19 kernel.
> How well are ixp432/ixp435 chips supported in new kernels.
> I would like to move it to 2.6.35 kernel.
>
> If I want to look at the latest patched for IXP4xx, is there good spot
> to look at ( gitweb or URL).

They should work fine, except possibly a problem with "coherent" memory
allocations, which is being worked on, and for which a usable patch is
available.
-- 
Krzysztof Halasa
