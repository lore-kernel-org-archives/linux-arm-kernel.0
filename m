From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Sep 2013 10:40:19 -0700
Subject: [GIT PULL] DaVinci fixes for v3.12-rc
In-Reply-To: <523BE5CA.3010601@ahsoftware.de>
References: <523AD060.8000504@ti.com>
 <CAOesGMg_L-0kqY2oexV=WY4mEWpCQdAej_h8QGxrtCgC=xSijg@mail.gmail.com>
 <523BE5CA.3010601@ahsoftware.de>
Message-ID: <CAOesGMi4z_wVVe6GfyWQ+7OApH0pHJe3ak90smJtf4nyJbu14A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 19, 2013 at 11:06 PM, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 19.09.2013 19:48, schrieb Olof Johansson:
>> Hi Sekhar,
>>
>> On Thu, Sep 19, 2013 at 3:22 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
> ...
>
>>> 3) A patch to complete the DT support for EDMA. Without
>>>    this patch, the DT support for EDMA cannot be used.
>>>    There are no in-tree DT users of EDMA currently but
>>>    nevertheless the patch fixes a previously incomplete
>>>    implementation.
>>
>> Finishing incomplete work is not a fix, especially if the users aren't
>> in-tree. The other patches are just fine to include though.
>
> It fixes problems for all people which are not using the provided DT's
> but using edma in their own DT. So I don't understand your arguing as DT
> got introduced to not only support in-tree configs. It clearly fixes
> problems.

Right, that was the smaller part of the argument. The bigger is:
Completing a feature is not a fix. If the whole feature didn't make it
in for a release, then the rest goes into the next release.


-Olof
