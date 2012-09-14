From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 14 Sep 2012 12:46:51 +0530
Subject: [Query] Does u-boot processes dtb file
In-Reply-To: <5052D7EA.30902@de.bosch.com>
References: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>
 <5052D7EA.30902@de.bosch.com>
Message-ID: <CAKohpomubFQMj2uoP+Pb1xBsO7B14W3nR1ddSQ-ajRERNBQ+kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2012 12:38, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> Working with U-Boot, to my understanding U-Boot modifies ('patches') the dtb
> read from the boot device before passing it to the kernel. It e.g. adds the
> kernel command line and the memory size you specify in U-Boot to the dtb.

Thanks for your response.

But, if this information is also embedded in the dts earlier, will my workaround
of filling r2 work?

Is filling bootargs and memory size the only stuff or some other things too?

--
viresh
