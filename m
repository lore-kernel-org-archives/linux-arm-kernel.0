From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 30 Sep 2014 11:45:52 -0700
Subject: [PATCH v2 0/4] ARM: dts: apq8064 DT patches
In-Reply-To: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
 (Srinivas Kandagatla's message of "Tue, 30 Sep 2014 15:09:19 +0100")
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <7hvbo5vten.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> These patches adds dt nodes for RPM, USB and SATA IPs found in APQ8064.
> All the driver support for these IPs are already available in v3.17, except
> the RPM driver which is now accepted by Lee and Mark.
>
> These patches depend on the header file from 
> http://www.spinics.net/lists/arm-kernel/msg364310.html
> for regulators.
>
> Now that the RPM patch is accepted, should RPM patch go via arm-soc tree?
> so that we can get more functionality on IFC6410 board in v3.18 mainline.
>
> All these patches are tested on IFC6410 board.
> Am hoping to get these patches for v3.18, as these patches were sitting in
> my dev tree since last 3 merge windows.

A nit on process, for future reference:

You only need to send to arm at kernel.org if you're expecting the arm-soc
maintainers to directly apply the patches or pull request.

In this case, it seems like stuff that the qcom maintainers will queue
up in their DT branch, and then submit to arm-soc maintainers.

Kevin
