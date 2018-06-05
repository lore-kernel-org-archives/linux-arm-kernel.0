From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 5 Jun 2018 09:11:39 +0200
Subject: [PATCH V2 2/2] arm: dts: sunxi: Add missing cooling device
 properties for CPUs
In-Reply-To: <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
References: <20180601151701.sshwfdbflic6mybv@flea>
 <d894f425b7c32bce4dc4a982db8f4dface2db31d.1528173943.git.viresh.kumar@linaro.org>
 <a313ec0be4104494de319e8318e05614fb97b2fd.1528173943.git.viresh.kumar@linaro.org>
Message-ID: <20180605071139.osu2pgpg3ychdxln@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 10:17:49AM +0530, Viresh Kumar wrote:
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
> Fix other missing properties (clocks, OPP, clock latency) as well to
> make it all work.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied both, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/15dccabc/attachment.sig>
