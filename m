From: tim.kryger@linaro.org (Tim Kryger)
Date: Mon, 25 Nov 2013 17:41:06 -0800
Subject: [PATCH 1/5] Documentation: dt: Add kona-pwm binding
In-Reply-To: <20131119135654.GL5914@e106331-lin.cambridge.arm.com>
References: <1384800901-21711-1-git-send-email-tim.kryger@linaro.org>
 <1384800901-21711-2-git-send-email-tim.kryger@linaro.org>
 <20131119135654.GL5914@e106331-lin.cambridge.arm.com>
Message-ID: <CAAYSxhr4RVifzxK_AFx9ju+Sp2j_PUsg+Be1xAHQ_HTopbJ8Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 5:56 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Nov 18, 2013 at 06:54:57PM +0000, Tim Kryger wrote:

>> +Required Properties :
>> +- compatible: should be "brcm,kona-pwm"
>> +- reg: physical base address and length of the controller's registers
>> +- clocks: clock specifier for the kona pwm external clock
>
> Minor nit: phandle + clock-specifier pair

I will incorporate this change into my next version.  Thanks.

-Tim
