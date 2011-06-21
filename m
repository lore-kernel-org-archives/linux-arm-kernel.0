From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jun 2011 13:36:15 -0700
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <BANLkTi=ik=iRtDb3K__CPxSH_8GusoBHKA@mail.gmail.com>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>	<4DFA5C2E.40507@codeaurora.org>
	<BANLkTi=ik=iRtDb3K__CPxSH_8GusoBHKA@mail.gmail.com>
Message-ID: <4E0100BF.6080500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2011 11:54 PM, Vincent Guittot wrote:
> On 16 June 2011 21:40, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> The ARM ARM says these fields are IMPLEMENTATION DEFINED meaning that
>> different vendors may attribute different meaning to these fields if
>> they wish. Does that mean this should be a platform_*() function?
>>
> The ARM ARM also provides a recommended use of the fields of this
> register and the TRM of each Cortex adds some details. On the cortex
> A9, each platform can only set the value of the Cluster ID with the
> CLUSTERID pins. I have tried to consolidate the value of MPIDR  across
> several platforms and they all match with the description.
>
> Have you got an example of a MPIDR register which doesn't match with
> the implementation ?

Not that I know of. I'm more concerned with how the ARM ARM has two
recommended usages for these fields depending on virtualization or not.
I suppose we can handle that issue when it arises (or does your
implementation already handle that?)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
