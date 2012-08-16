From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 15 Aug 2012 18:48:13 -0600 (MDT)
Subject: [PATCH v5 0/8] ARM: OMAP2+: PM: introduce the power domains
 functional states
In-Reply-To: <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
 <CAMQu2gxznhsbK3--nyQmYdHqyGjwpCSa3CJx8aYpF4wwR1qBSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1208151842380.8833@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Wed, 15 Aug 2012, Shilimkar, Santosh wrote:

> On Wed, Aug 15, 2012 at 3:32 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
> I didn't find any mention here about why are we going in this path and not
> in the direction proposed in another RFC [1]
> I have already given my comments[2] against the introduction of another PD
> layer which can be avoided easily as demonstrated by the RFC[1]. The comments
> are still applicable for this series too.
> 
> We really need to reduce OMAP specific framework overhead and
> move towards more generic PM frameworks. For me, this series is
> a step back-ward from that direction. Am really sorry for being critical
> again but I remain unconvinced about this series and the problem it
> is trying to solve.
> 
> May be you have valid reasons not to follow the approach in [1] and in
> that case, it will be good to clarify that so that some of us get
> to know your rationale.

I've asked Jean to handle the work of evaluating and/or integrating any 
feedback from you and Rajendra into this series.  Jean, has this latest 
series fully considered those issues?  Or are there still some areas of 
misalignment / lack of clarity?

Anyway.  If there's a problem with this process, it sounds like you, 
Rajendra, Jean, Beno?t and I should schedule some time to talk over the 
same issues that you discussed with me on the phone.  Perhaps next week?


- Paul
