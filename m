From: robdclark@gmail.com (Rob Clark)
Date: Fri, 10 Apr 2015 17:01:51 -0400
Subject: [PATCH v2 06/12] ARM: dts: apq8064: Add MDP support
In-Reply-To: <552830C9.4030601@codeaurora.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1428669271-11032-1-git-send-email-srinivas.kandagatla@linaro.org>
 <552802B6.2040804@codeaurora.org> <552826F6.5040105@linaro.org>
 <552830C9.4030601@codeaurora.org>
Message-ID: <CAF6AEGtYQJVt+ETtgnhANJq8c8Z0CyQj=8UddGLL2FR+jpgXAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 4:21 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> That's true, These are existing bindings, so I can't change it as part
>> of this patch, However I will make another patch to fix this in both
>> drivers and DT for good reasons. Just noticed that bindings are not
>> consistent with the examples and the driver, which I guess is another
>> issue.
>
> Yes, the driver/binding should be fixed and then this patch can be
> corrected and applied. There are no implementations of the DT for this
> device upstream in the dts directory so there's no breakage or backwards
> incompatibility problem by fixing the driver/binding.


jfyi, some of the current bindings are the way they are to simplify
compatibility w/ downstream kernels which I unfortunately still have
to deal with.. ofc, the sooner I don't have to deal w/ downstream
kernels, the easier it gets to clean up ;-)

ofc, since the number of devices that can run upstream kernel but
don't have upstream dts files is approximately zero, this would be a
case were it would be useful to be able to mark certain bindings as
non-abi and refactor them later.

BR,
-R
