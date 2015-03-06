From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 17:59:35 -0800
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <07D4E4D1-BF8C-4583-9505-9F321DB10406@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <7h8ufbjkod.fsf@deeprootsystems.com>
 <07D4E4D1-BF8C-4583-9505-9F321DB10406@codeaurora.org>
Message-ID: <CAOesGMgy3VY=4-t+N0BYqCuSLQkh-rYe8nd9iJh1mMeBFz_sWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 5, 2015 at 12:23 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Mar 5, 2015, at 1:42 PM, Kevin Hilman <khilman@kernel.org> wrote:
>
>> Kumar Gala <galak@codeaurora.org> writes:
>>
>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>> on Qualcomm MSM platforms to determine which device tree should be
>>> utilized and passed to the kernel.
>>>
>>> Cc: <devicetree@vger.kernel.org>
>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>
>> Is this the special magic that allows qcom bootloaders to take a kernel
>> plus multiple DTBs and figure out which DTB to pass?
>>
>> Kevin
>
> yes

That's a bummer.

Luckily, the solution for upstream is still quite simple: Provide only
one devicetree, and it'll be used, right?


-Olof
