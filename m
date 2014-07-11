From: xerofoify@gmail.com (Nick Krause)
Date: Fri, 11 Jul 2014 11:24:12 -0400
Subject: mach-shmobile: FIXME message in file pm-sh732.c
In-Reply-To: <20140711093450.GA26660@verge.net.au>
References: <CAPDOMViqzoX_VAJKFB34LXLBVUBTbs4hWq-K_8+bC-m2NmahCQ@mail.gmail.com>
 <20140711093450.GA26660@verge.net.au>
Message-ID: <CAPDOMVgi-GMQp101eZewVBOK_nFD8UJ04UydQ6bxa6Y5FP_VgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 5:34 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jul 04, 2014 at 12:34:58AM -0400, Nick Krause wrote:
>> While searching for FIX ME messages when using cscope on the latest kernels I
>> get a message on 68 of this file and was wondering what I need to define SMFRAM
>> as in order for it to point to things needed to support this portion
>> of the  hardware.
>
> Hi Nick,
>
> while I don't have a technical answer to your question I do believe
> that the code in question will be removed in the not too distant future
> along with support for the sh7372 SoC.

Why are we removing support for this SoC? Is there any reason?
Nick
