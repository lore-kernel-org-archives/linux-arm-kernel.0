From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 28 Mar 2014 17:35:24 +0100
Subject: [ARM ATTEND] general discussion, DT (fragments?) and TrustZone
Message-ID: <5335A4CC.2000406@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am Atmel AT91 Co-Maintainer and would like to attend the ARM Linux
mini-summit or BoF. I will be attending ELC as well.

I'd love to discuss the following topics with you guys:

- current effort toward AT91 DT conversion, where do we stand, what
  are the future plans and what are the best ways to move
  old platforms to DT-only

- integration of AT91 to ARM multiplatform initiative. Following our
  adoption of CCF, I would like to summarize what is remaining to be
  done before integrating the multiplatform single zImage kernel

- best DT practices for handling little differences in
  hardware platforms:
  - subtle HW changes in relation to board revisions
  - addition of daughter boards, modules, capes, shields
  - use of DT fragments: status, best practices,
    location of DT fragments
  Without a proper mechanism we quickly observe a huge amount
  of different .dtsi/.dts files popping up!

- TrustZone and the Linaro Open Source Trusted Execution Environment:
  how ARM Linux will interact with this initiative and which part of
  the Linux kernel would implement the calls to the TEE API.


Thanks, bye.
-- 
Nicolas Ferre
