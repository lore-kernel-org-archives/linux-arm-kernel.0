From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 21 Aug 2015 09:36:22 +0200
Subject: [RESEND PATCH] dmaengine: Add Xilinx AXI Direct Memory Access
 Engine driver support
In-Reply-To: <CAAtXAHe3QjBo4_5unB32ixnOriO8Xt-1nLeddjgRgYvj5Kn_EA@mail.gmail.com>
References: <1439825512-16444-1-git-send-email-appanad@xilinx.com>
 <CAAtXAHf9S662okN1gchbD246=e4_bMFoyBMrbt5q48xm1uo_CA@mail.gmail.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4B2BBC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A4B2C48@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CAAtXAHe3QjBo4_5unB32ixnOriO8Xt-1nLeddjgRgYvj5Kn_EA@mail.gmail.com>
Message-ID: <55D6D4F6.4020100@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/21/2015 03:16 AM, Moritz Fischer wrote:
> Hi,
> 
> your MUA produces funny messages somehow ...
> The driver did not probe for me in it's current form as the bindings
> were missing interrupt parents for the interrupts...

It is just a question where interrupt parent is listed. I have seen that
some SoCs are just setting up at one location for all IPs.
I remember some discussions that some properties don't need to be
documented again and again. That's why the question is if they are
really needed to be documented in the binding doc because it is just
documentation duplication in every binding document.

Definitely if you miss it in the binding doc, feel free to send the
patch and update it.

Thanks,
Michal
