From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jun 2012 09:37:08 +0100
Subject: [PATCH 07/14] mfd: Initialise the AB8500 driver at core_initcall
 time
In-Reply-To: <CACRpkdY8aD1djSdPoeKYDdFVbf3E84ZWw2Q5CCLsPmoD66Hf7A@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdY8aD1djSdPoeKYDdFVbf3E84ZWw2Q5CCLsPmoD66Hf7A@mail.gmail.com>
Message-ID: <4FD6FFB4.8080109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/12 22:03, Linus Walleij wrote:
> On Mon, Jun 11, 2012 at 5:25 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>
>> The AB8500 is soon to have its own IRQ domain. For this to be useful
>> the driver needs to be initialised earlier in the boot sequence. Here
>> we move initialisation forward from arch_initcall to core_initcall time.
>
> I don't understand why using IRQ domain makes it necessary to
> initialize the driver earlier in the init process. Please explain to me,
> I need tutoring here.

See the other email.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
