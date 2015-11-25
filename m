From: riku.voipio@linaro.org (Riku Voipio)
Date: Wed, 25 Nov 2015 14:36:16 +0200
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <56554AE9.5070901@jonmasters.org>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
 <56554AE9.5070901@jonmasters.org>
Message-ID: <CAAqcGHnqeivOmcJYSKdf6CqHhPdEb_HiMO4MtK0bfZxzzQk7bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2015 at 07:45, Jon Masters <jcm@jonmasters.org> wrote:
> On a total tangent, it would be ideal to (eventually) have something
> reported in /proc/cpuinfo or dmesg during boot that does "accurately" map
> back to the underlying core frequency (as opposed to the generic timer
> frequency).

Try:

grep . /sys/devices/system/cpu/cpu?/cpufreq/scaling_cur_freq
