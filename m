From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 May 2014 20:41:47 +0200
Subject: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
In-Reply-To: <5388D02D.4020209@arm.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>	<1401440477-4328-3-git-send-email-thomas.ab@samsung.com>	<20140530130827.GK24233@leverpostej>
 <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com>
 <5388CAC5.5010607@gmail.com> <5388D02D.4020209@arm.com>
Message-ID: <5388D0EB.1090001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.05.2014 20:38, Sudeep Holla wrote:
> On 30/05/14 19:15, Tomasz Figa wrote:
>> On 30.05.2014 20:05, Thomas Abraham wrote:
>>> On Fri, May 30, 2014 at 6:38 PM, Mark Rutland <mark.rutland@arm.com>
>>> wrote:

[snip]

>>>> Why are these in both operating-points and boost-frequencies? It'll be
>>>> really easy to accidentally forget to mark something as a
>>>> boost-frequency this way. Why not have a boost-points instead?
>>>
> 
> I was told that index is not preferred based on the previous discussions
> when the OPP bindings were designed. In addition the OPP binding doesn't
> enforce any ordering. There are thermal bindings that assume otherwise and
> is broken. So boost-points is not feasible.
> 

My understanding of Mark's comment was that the boost-points property
would use the same format as operating-points and parsing code would
just concatenate operating points with boost points after making the
latter with necessary flag or whatever.

Best regards,
Tomasz
