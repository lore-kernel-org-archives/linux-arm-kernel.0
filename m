From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Nov 2013 21:28:01 -0800
Subject: [PATCH] Documentation: devicetree: arm: add lpae property to
 cpus/cpu bindings
In-Reply-To: <CAOesGMh9aQEtqha3gt80q4RmLjXtFTc+Xt39M0m+geTk_betzQ@mail.gmail.com>
References: <1385517172-803-1-git-send-email-olof@lixom.net>
 <20131127094911.GE5402@e106331-lin.cambridge.arm.com>
 <CAOesGMh9aQEtqha3gt80q4RmLjXtFTc+Xt39M0m+geTk_betzQ@mail.gmail.com>
Message-ID: <CAOesGMh45EyTm5ZEAXphiD5L=cyLQ=732qZfW1jtQDo8Rd9rpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 11:27 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Nov 27, 2013 at 1:49 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi Olof,
>>
>> On Wed, Nov 27, 2013 at 01:52:52AM +0000, Olof Johansson wrote:
>>> While the LPAE capability is determined by the kernel today, it is still
>>> useful to be able to specify the feature in the device tree. There is
>>> precedence from other architectures for this.
>>>
>>> Signed-off-by: Olof Johansson <olof@lixom.net>
>>> ---
>>>
>>> My personal motive for this is to be able to tell which boards are
>>> work even trying to boot an LPAE kernel on, since we don't disable the
>>> platforms that are based on A8/A9 when LPAE is turned on. I'll add dtsi
>>> patches for A7/A15-based platforms once the binding is settled.
>>
>> It would be nice to have this description of why you want to add this in
>> the commit message proper.
>
> Sure.


By the way, I ended up doing it a different way than depending on DT
contents, so I don't have a need to push for this now.

Still, I think it's worth resolving long-term (how to encode CPU
features on ARM as properties), but lower priority.


-Olof
