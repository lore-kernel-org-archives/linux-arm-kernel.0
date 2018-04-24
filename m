From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Apr 2018 16:57:39 +0100
Subject: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR bus bindings
In-Reply-To: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
Message-ID: <20180424155739.GC22073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla at linaro.org wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> > This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> > bus driver. This bus is used for communicating with DSP which provides
> > audio and various other services to cpu.

> This should probably go under bindings/sound/ as it is at least mostly 
> sound related.

AIUI the same interface is used for other DSP functionality - they're
upstreaming audio stuff right now but I believe there should be more to
come.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/0bec3833/attachment-0001.sig>
