From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 30 Mar 2011 16:06:45 -0500
Subject: /proc/cpu/clocks
In-Reply-To: <20110330191938.GE2939@n2100.arm.linux.org.uk>
References: <AANLkTikBgq0bSRSQRSzeu==ByemegSB+x7AXXeJjR_ct@mail.gmail.com>
	<20110330191938.GE2939@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik6NQvgT1sdFf7Vg-nXCM1PKv43WhqnzOJuR=cV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah okay. So we get to bug Freescale :)

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.



On Wed, Mar 30, 2011 at 2:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 30, 2011 at 11:27:46AM -0500, Matt Sealey wrote:
>> Where did /proc/cpu/clocks go in the kernel and where can I find the
>> equivalent information?
>
> It has never existed as a generic thing in mainline. ?If some platform
> added it then it was private to that platform.
>
