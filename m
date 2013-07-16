From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Jul 2013 11:59:11 +0530
Subject: [RFC PATCH 02/11] ARM: DT/kernel: define ARM specific
 arch_of_get_cpu_node
In-Reply-To: <51E44943.7000600@gmail.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1373883732-26303-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51E44943.7000600@gmail.com>
Message-ID: <CAKohponBwiHfty8er+xhT7CksfFDYZ=3cNyvZA-G0UDCj=tLsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2013 00:40, Rob Herring <robherring2@gmail.com> wrote:
> The powermac cpufreq driver could probably also be converted
> (arch/powerpc/platforms/powermac/cpufreq_64.c).

Its called: drivers/cpufreq/pmac64-cpufreq.c now.
