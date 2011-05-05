From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 5 May 2011 16:31:11 -0400
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <4DC307D0.3090704@am.sony.com>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com> <4DC2E669.2000101@am.sony.com>
	<1304620350.2398.29.camel@i7.infradead.org>
	<4DC2EF19.5010309@am.sony.com>
	<alpine.LFD.2.00.1105051453280.24613@xanadu.home>
	<BANLkTimfKJPcDN+L4+z1DnsMv_BMOHpyew@mail.gmail.com>
	<4DC2F6B0.80800@am.sony.com>
	<BANLkTincnFhwXAyvua5mtZDHqXs5Vts--Q@mail.gmail.com>
	<4DC307D0.3090704@am.sony.com>
Message-ID: <BANLkTi=qiX9oG=ZMx0nZXrG811L7OZg4ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 16:25, Tim Bird wrote:
> On 05/05/2011 12:27 PM, Mike Frysinger wrote:
>> On Thu, May 5, 2011 at 15:12, Tim Bird wrote:
>>> As for in-tree-ness - I thought the most recent message was to stay
>>> out of tree until the refactoring was over. ;-)
>>
>> to be fair, does this have any relevance whatsoever to NEC parts ?
>> istm that the hindrance here is NEC doing any actual work for
>> mainline. ?even if there was no refactoring, i find it hard to believe
>> that an NEC port would be posted. ?if it were actually something that
>> could happen, then they should already be posting patches for *basic*
>> review to get the pieces unrelated to the refactoring worked out.
>> there's no reason this has to be done serially.
>
> Well, OK. ?I just don't want to lob bombs at NEC and then
> have some poor soul over there get immediately rebuffed, due to
> basic ARM churn. ?Maybe not having naviengine support upstream
> is my fault, but Sony doesn't make the CPU, so it doesn't seem
> like it should be my job to mainline the chip support. ?About
> the only thing I have at my disposal is pressure not to buy
> the chip (but this is harder to exercise than one might think.)

i dont have any vested interest either way wrt NEC or ARM/XIP.  i was
just trying to highlight what i saw as a red herring.

i think the axiom "post early & post often" holds just as true here.
-mike
