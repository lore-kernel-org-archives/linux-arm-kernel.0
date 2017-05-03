From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 May 2017 12:33:48 -0500
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <CAOesGMiY9o8199bb13gsd3SAs8YR-4rafYHoyV3VmK0dY0MDtQ@mail.gmail.com>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
 <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
 <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
 <CAOesGMiY9o8199bb13gsd3SAs8YR-4rafYHoyV3VmK0dY0MDtQ@mail.gmail.com>
Message-ID: <4b048ba1-b7e4-6ab6-95be-3163120f63aa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2017 12:26 PM, Olof Johansson wrote:
> arm at kernel.org as an email alias will break down if it starts being
> cc:d on large number of patches. Ideally we want the platform
> maintainers as filters/reviewers in front to keep the volume down. So
> far it's been kept to nearly only material from maintainers, and
> mostly pull requests.
> 
> Defconfig changes usually come in through maintainers. Said
> maintainers already know to send code to us at arm at kernel.org for
> their platforms. So this should probably go in through Andy Gross? You
> didn't even cc him, so added now.

How would I know to CC: him, or anyone else, without a MAINTAINERS entry?
I've already posted these patches 5 times, and every time I do, someone
tells me that I'm CCing the wrong person.

Are you saying that I should send the 9 patches to 9 different people, and
just pray that they all get merged in properly?  Each of the maintainers is
going to ask for an ACK from an ARM maintainer anyway, whoever he is (I
don't know any more).

There's got to be a better way.

> We won't consider any patches at this very time, since we're in the
> middle of the merge window. Main priority right now is to prepare the
> material we have for pull requests and merge.
> 
> This is not the time to send us new material, but you probably already
> know that.

Fair enough, but the patches aren't new.  They've been been floating on the
list for three weeks now.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
