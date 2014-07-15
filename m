From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 15 Jul 2014 23:33:49 +0530
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
Message-ID: <CAJe_ZheGrGZMVXZN2SMtBtq4+fX7KsiMSEfAM0mVcb6f80Kckg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2014 20:41, Rob Herring <robherring2@gmail.com> wrote:

...

>> +               interrupts = <0 36 4>, /* LP Non-Sec */
>> +                            <0 35 4>, /* HP Non-Sec */
>> +                            <0 37 4>; /* Secure */
>> +       };
>> +
>> +       mhu_client: scb at 0 {
>> +               compatible = "fujitsu,scb";
>> +               mbox = <&mhu 1>;
>
> Is the mailbox binding finalized?
>
I have sent a patchset for common mailbox and its bindings. You are on
CC list. Arnd seems OK with it.

....

Will address rest all of your comments.

>
> That's all I've got time and energy for reviewing for now.
>
Thanks a lot!
-Jassi
