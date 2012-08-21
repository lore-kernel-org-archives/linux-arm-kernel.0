From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Aug 2012 09:29:48 +0200
Subject: [RFC] Add support for Aurora L2 Cache Controller
In-Reply-To: <CAHkRjk4qPPktXsqnRaZLG0Z=VMH_Qf6xRdQBPMvxC20m6noc+A@mail.gmail.com>
References: <1344438307-8468-1-git-send-email-gregory.clement@free-electrons.com>
 <CAHkRjk4qPPktXsqnRaZLG0Z=VMH_Qf6xRdQBPMvxC20m6noc+A@mail.gmail.com>
Message-ID: <503338EC.4070303@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 05:16 PM, Catalin Marinas wrote:> On 8 August 2012 16:05, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> - two flavors of the controller 'outer cache' and 'system cache' (the
>>   last one meaning maintenance operations on L1 are broadcasted to the
>>   L2 and L2 performs the same operation).
>
> BTW, is the DSB also transparently handled by the L2 in 'system cache' mode?
>

The information I have is that from the point view of the software
there is no need to take any extra actions when using this kind of
command, everything is handle by the hardware. So I guess that the
answer to your question should be yes.

---
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
