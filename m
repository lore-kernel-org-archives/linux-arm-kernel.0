From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 2 Dec 2014 09:20:13 +0100
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <3594266.ci9lGXQ9iA@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
 <5607434.rlEIdu4yyh@wuerfel>
 <CAKohpomsqCnEcSeuqtZcYOC6bgTrGmc8zXTm6cA72q+hr=LBsQ@mail.gmail.com>
 <3594266.ci9lGXQ9iA@wuerfel>
Message-ID: <20141202092013.6017a9b0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Mon, 01 Dec 2014 15:59:14 +0100, Arnd Bergmann wrote:

> I still don't see where it does that. All I see for mvebu is
> 
> 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> 
> without any platform data. I see this patch
> http://lists.linaro.org/pipermail/linaro-kernel/2014-September/017693.html
> on the mailing list, but it's not in linux-next, and it obviously
> would not work any more with the patch I proposed. Instead I suppose
> you would use a different string to match against for the case of
> separate clocks.

Hum, right. Actually, only the cpufreq driver part has been taken, and
I forgot to resubmit the mach-mvebu part of the solution. I'll do so
today.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
