From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 11 Sep 2011 23:01:24 -0400 (EDT)
Subject: [PATCH v2 03/10] ARM: kprobes: Framework for instruction set test
	cases
In-Reply-To: <1315652706-2900-4-git-send-email-tixy@yxit.co.uk>
References: <1315652706-2900-1-git-send-email-tixy@yxit.co.uk>
	<1315652706-2900-4-git-send-email-tixy@yxit.co.uk>
Message-ID: <alpine.LFD.2.00.1109112259110.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Sep 2011, Tixy wrote:

> From: Jon Medhurst <tixy@yxit.co.uk>
> 
> On ARM we have to simulate/emulate CPU instructions in order to
> singlestep them. This patch adds a framework which can be used to
> construct test cases for different instruction forms. It is described in
> detail in the in-source comments of kprobes-test.c
> 
> Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
> ---

[...]

> + * Th pair of test case runs is repeated with different combinations of
> + * flag values in CPSR and, for Thumb, different ITState.

s/Th/The/

(noticed this typo by chance I suppose  ;-))


Nicolas
