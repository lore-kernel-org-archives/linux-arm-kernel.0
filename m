From: woogyom.kim@gmail.com (Milo Kim)
Date: Thu, 1 Sep 2016 21:51:00 +0900
Subject: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
In-Reply-To: <CAGb2v66etp0AsYvs8n3MgBXehqV=kwkSnuq=Kt=aLtH4xvcDkA@mail.gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
 <CAGb2v66etp0AsYvs8n3MgBXehqV=kwkSnuq=Kt=aLtH4xvcDkA@mail.gmail.com>
Message-ID: <85db83b5-a98d-dfc2-5082-8b235f2185c2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2016 05:33 PM, Chen-Yu Tsai wrote:
>> +                       pwm0_pin_a: pwm0 at 0 {
> This is the only possible configuration. You can drop the _a suffix
> from the label, and @0 from the node name.

OK, thanks for your review.

Best regards,
Milo
