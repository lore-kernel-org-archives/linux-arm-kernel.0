From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 8 Feb 2018 15:09:08 +0100
Subject: [PATCH] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
In-Reply-To: <CA+M3ks4kCpcNfd1NyVLDtPOKmDniteXw2-iUqUikeicRdRAa6A@mail.gmail.com>
References: <20180122102608.12565-1-philippe.cornu@st.com>
 <3169703.7pajs7FEnH@avalon>
 <2bf185e2-9b02-3632-dc9a-baf8f4109b44@st.com> <2205915.z0ubSpqczI@avalon>
 <CA+M3ks4kCpcNfd1NyVLDtPOKmDniteXw2-iUqUikeicRdRAa6A@mail.gmail.com>
Message-ID: <CAOFm3uFZeMNBGnvAtPMiMMXuV-3tFTbxH-Y1cv-hAgZ4dUmA=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin,

On Wed, Jan 24, 2018 at 9:57 AM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> 2018-01-24 0:32 GMT+01:00 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>> Hi Philippe,
>>
>> On Tuesday, 23 January 2018 12:25:51 EET Philippe CORNU wrote:
>>> On 01/23/2018 12:30 AM, Laurent Pinchart wrote:
>>> > On Monday, 22 January 2018 12:26:08 EET Philippe Cornu wrote:
>>> >> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
>>> >> host controller driver.
>>> >>
>>> >> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>>> >> ---
>>> >>
>>> >>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>>> >>   1 file changed, 1 insertion(+), 5 deletions(-)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> >> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
>>> >> 46b0e73404d1..e06836dec77c 100644
>>> >> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> >> @@ -1,12 +1,8 @@
>>> >> +// SPDX-License-Identifier: GPL-2.0
>>> >
>>> > According to Documentation/process/license-rules.txt this would change
>>> > the existing license. The correct identifier is GPL-2.0+.
>>>
>>> You are right, I did not put the correct identifier :(
>>>
>>> After reading more spdx.org, I wonder if the correct value should be
>>> GPL-2.0-or-later instead of GPL-2.0+
>>>
>>> https://spdx.org/licenses/GPL-2.0-or-later.html
>>> https://spdx.org/licenses/GPL-2.0+.html
>>>
>>> What is your opinion?
>>
>> I agree in principle, and I've even asked for that before, but I've been told
>> that we should stick to the license identifiers defined in Documentation/
>> process/license-rules.txt. The file might get updated to use GPL-2.0-or-later
>> and GPL-2.0-only later, and kernel sources will likely then get patched in one
>> go.
>
> + Philippe O. to check what I'm writing just below.
>
> In -next branch I only see reference to GPL-2.0+ identifier so for me
> it fine to use it here.
> Is that right ? or should we use GPL-2.0-or-later keyword ?


Sorry for the late reply!
IMHO it is essential to stick to what is in the kernel doc, meaning
that you should not use the GPL-2.0-or-later identifier until it is
part of the kernel doc. Otherwise this is going to be a mess ;)
Consistency matters a lot.
-- 
Cordially
Philippe Ombredanne
