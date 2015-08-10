From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 10 Aug 2015 16:25:52 -0700
Subject: [PATCH v1 7/7] ARM: dts: ifc6410: add inforce LVDS panel support
In-Reply-To: <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1438088076-17606-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150810232552.GB13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 28 Jul 05:54 PDT 2015, Srinivas Kandagatla wrote:

> This patch adds LVDS panel for IFC6410.
> 

My ifc6410 doesn't have a LVDS display, so I don't think these nodes
belong in this dts file.

I was thinking we could have a variant including this dts file adding
the panel, but I assume that you can mount other panels than the auo
panel defined below?


Either way, I think we should keep this file to define the stuff that's
on the IFC6410 itself and then figure out how to aid people in adding
the rest of their additions...

Regards,
Bjorn
