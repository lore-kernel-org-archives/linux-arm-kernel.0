From: olof@lixom.net (Olof Johansson)
Date: Wed, 3 May 2017 10:26:28 -0700
Subject: [PATCH] MAINTAINERS: add arm@kernel.org as the list for arm64
 defconfig changes
In-Reply-To: <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
References: <1493829085-11864-1-git-send-email-timur@codeaurora.org>
 <20170503170110.GB23620@e104818-lin.cambridge.arm.com>
 <95597ce9-a46f-1491-ae65-518ed8b8c44c@codeaurora.org>
Message-ID: <CAOesGMiY9o8199bb13gsd3SAs8YR-4rafYHoyV3VmK0dY0MDtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, May 3, 2017 at 10:08 AM, Timur Tabi <timur@codeaurora.org> wrote:
> On 05/03/2017 12:01 PM, Catalin Marinas wrote:
>> On Wed, May 03, 2017 at 11:31:25AM -0500, Timur Tabi wrote:
>>> > Any changes to arch/arm64/configs/defconfig must be sent to arm at kernel.org,
>>> > otherwise they will not get picked up.  Add a MAINTAINERS entry to ensure
>>> > the get_maintainers includes it.
>> There are other patches that go through arm at kernel.org like
>> arch/arm64/boot/dts/ but the arm-soc guys didn't want a MAINTAINERS
>> entry (I don't remember the reasons).
>
> I'm happy to add additional paths/files, but without a MAINTAINERS entry,
> how would anyone know to CC: that address?  I posted 3 versions of my
> defconfig patchset before someone told me that I had to send it to
> arm at kernel.org.

arm at kernel.org as an email alias will break down if it starts being
cc:d on large number of patches. Ideally we want the platform
maintainers as filters/reviewers in front to keep the volume down. So
far it's been kept to nearly only material from maintainers, and
mostly pull requests.

Defconfig changes usually come in through maintainers. Said
maintainers already know to send code to us at arm at kernel.org for
their platforms. So this should probably go in through Andy Gross? You
didn't even cc him, so added now.

> Anyway, I really hope it's not too late for my defconfig changes to make
> 4.12.  Please consider them.  Thank you.

We won't consider any patches at this very time, since we're in the
middle of the merge window. Main priority right now is to prepare the
material we have for pull requests and merge.

This is not the time to send us new material, but you probably already
know that.


-Olof
