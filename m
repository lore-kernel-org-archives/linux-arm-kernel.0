From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 22:26:03 +0100
Subject: [PATCH v2 1/2] ARM: dts: add cubietech cubieboard4
In-Reply-To: <1425932398-7194-2-git-send-email-tyler.baker@linaro.org>
References: <1425932398-7194-1-git-send-email-tyler.baker@linaro.org>
 <1425932398-7194-2-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150310212603.GB5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 01:19:57PM -0700, tyler.baker at linaro.org wrote:
> From: Tyler Baker <tyler.baker@linaro.org>
> 
> Add a Cubietech Cubieboard4 device tree and instruct make to build it. This
> device tree has been derived from the sun9i-a80-optimus.dts as they are very
> similar in design[1]. Notably, I2C3 is not used on Cubieboard4 and the LED/PWM
> definitions will need to be updated in the future.
> 
> [1] http://dl.cubieboard.org/model/cc-a80/Hardware/CC-A80-HW-V1.1.pdf
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/59cd9e6d/attachment.sig>
