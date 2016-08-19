From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Aug 2016 07:45:00 -0500
Subject: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
In-Reply-To: <20160819083557.GK4254@dell>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-18-lee.jones@linaro.org>
 <20160818192002.GA26225@rob-hp-laptop> <20160819083557.GK4254@dell>
Message-ID: <CAL_JsqLOoU0gHiz7CEii3CXsGQS28u2+w5t7vxT1FStRaeObkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 3:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 18 Aug 2016, Rob Herring wrote:
>
>> On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
>> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
>> > be more inline with the naming conventions of the subsystem.  Where
>> > we used to treat each line as a channel, the PWM convention is to
>> > describe them as devices.
>>
>> This is out of date now. Otherwise, the binding looks fine.
>
> Yes, you are right.
>
> Perhaps if this is okay with Thierry, he can remove these few lines.
> If not, I don't mind re-sending on request.
>
> I'll leave it until I hear otherwise.

Fine with me.

Acked-by: Rob Herring <robh@kernel.org>
