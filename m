From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Fri, 9 Nov 2018 10:35:37 +0800
Subject: [PATCH v4] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
In-Reply-To: <1541588652-17380-1-git-send-email-robert.walker@arm.com>
References: <1541588652-17380-1-git-send-email-robert.walker@arm.com>
Message-ID: <20181109023537.GB4219@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 11:04:12AM +0000, Robert Walker wrote:
> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
> 
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.10.0 of OpenCSD.  A check for the OpenCSD
> library version has been added to the feature check for OpenCSD.

I have applied this patch on latest mainline kernel and tested for
A64/A32/T32 insntructions.

Tested-by: Leo Yan <leo.yan@linaro.org>
