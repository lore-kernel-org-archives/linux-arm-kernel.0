From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Mar 2015 11:15:11 -0800
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <B8019148-3B26-453E-A3F0-9D67874083E0@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <7h8ufbjkod.fsf@deeprootsystems.com>
 <07D4E4D1-BF8C-4583-9505-9F321DB10406@codeaurora.org>
 <CAOesGMgy3VY=4-t+N0BYqCuSLQkh-rYe8nd9iJh1mMeBFz_sWQ@mail.gmail.com>
 <B8019148-3B26-453E-A3F0-9D67874083E0@codeaurora.org>
Message-ID: <CAOesGMjpOx4SxY7j8jnoEwLG+mhPKB2st8qCb-hduHLOVw=RcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 8:08 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Mar 5, 2015, at 7:59 PM, Olof Johansson <olof@lixom.net> wrote:
>
>> On Thu, Mar 5, 2015 at 12:23 PM, Kumar Gala <galak@codeaurora.org> wrote:
>>>
>>> On Mar 5, 2015, at 1:42 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>
>>>> Kumar Gala <galak@codeaurora.org> writes:
>>>>
>>>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>>>> on Qualcomm MSM platforms to determine which device tree should be
>>>>> utilized and passed to the kernel.
>>>>>
>>>>> Cc: <devicetree@vger.kernel.org>
>>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>>
>>>> Is this the special magic that allows qcom bootloaders to take a kernel
>>>> plus multiple DTBs and figure out which DTB to pass?
>>>>
>>>> Kevin
>>>
>>> yes
>>
>> That's a bummer.
>>
>> Luckily, the solution for upstream is still quite simple: Provide only
>> one devicetree, and it'll be used, right?
>
> We can provide only one, we still need the IDs in the DT.

How are the DTS provided? Concatenated with the kernel, or in a
wrapped data format? Or in a separate partition from the kernel?


-Olof
