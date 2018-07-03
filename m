From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 15:34:31 +0800
Subject: [PATCH 2/6] arm64: dts: freescale: Add missing cooling device
 properties for CPUs
In-Reply-To: <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
Message-ID: <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 1:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>
> Add such missing properties.
>
> Do minor rearrangement as well to keep ordering consistent.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks.

Please use my kernel.org email address for future patches.

Shawn
