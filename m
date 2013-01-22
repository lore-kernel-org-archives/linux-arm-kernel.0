From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 22 Jan 2013 11:49:27 +0100
Subject: [PATCH 2/5] ARM: dts: twl6030: Add PWM support
In-Reply-To: <50FE6C5E.50802@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
 <1358519794-13214-3-git-send-email-peter.ujfalusi@ti.com>
 <50FE6C5E.50802@ti.com>
Message-ID: <50FE6EB7.8070605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Benoit,

On 01/22/2013 11:39 AM, Benoit Cousson wrote:
>> +
>> +	twl_pwm: pwm {
>> +		/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
>> +		compatible = "ti,twl6030-pwm";
>> +		#pwm-cells = <2>;
>> +	};
>> +
>> +	twl_pwmled: pwmled {
>> +		/* provides one PWM (id 0 for Charing indicator LED) */
> 
> typo: charging.

Aargh. Corrected in the branch.

Thanks,
P?ter
