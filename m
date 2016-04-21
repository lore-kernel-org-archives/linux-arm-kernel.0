From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Apr 2016 10:54:02 +0200
Subject: [PATCH 6/8] cpufreq: sunxi: Use generic platdev driver
In-Reply-To: <e82bf5994897cc979a67c72f09229b8b295bb69a.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <e82bf5994897cc979a67c72f09229b8b295bb69a.1461228081.git.viresh.kumar@linaro.org>
Message-ID: <20160421085402.GL13045@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 02:13:52PM +0530, Viresh Kumar wrote:
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160421/9c237690/attachment.sig>
