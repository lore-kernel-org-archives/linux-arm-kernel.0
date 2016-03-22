From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Mar 2016 20:41:33 -0500
Subject: [PATCH v2 3/5] dt-bindings: Add documentation for GM20B GPU
In-Reply-To: <CAAVeFuKQvjb20aEh9_MBnrzEUjKoVc8yQu3a4Ego6Qaqe70M6A@mail.gmail.com>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
 <1458010724-10945-4-git-send-email-acourbot@nvidia.com>
 <20160318204748.GA20243@rob-hp-laptop>
 <CAAVeFuKQvjb20aEh9_MBnrzEUjKoVc8yQu3a4Ego6Qaqe70M6A@mail.gmail.com>
Message-ID: <CAL_Jsq+SEOC1s_j8u3hMyDj5i9ROyAAN_-qmbsLrNvR3v2cXwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 20, 2016 at 1:55 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Sat, Mar 19, 2016 at 5:47 AM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Mar 15, 2016 at 11:58:42AM +0900, Alexandre Courbot wrote:
>>> GM20B's definition is mostly similar to GK20A's, but requires an
>>> additional clock.

[...]

>>>       gpu at 0,57000000 {
>>>               compatible = "nvidia,gk20a";
>>> @@ -45,3 +49,22 @@ Example:
>>>               iommus = <&mc TEGRA_SWGROUP_GPU>;
>>>               status = "disabled";
>>>       };
>>> +
>>> +Example for GM20B:
>>> +
>>> +     gpu at 0,57000000 {
>>
>> Drop the comma and leading zero.
>
> Even though this is how it appears in the actual DT?

Yes, those will need to get fixed, too.

Rob
