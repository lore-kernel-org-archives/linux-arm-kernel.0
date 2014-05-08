From: elder@linaro.org (Alex Elder)
Date: Thu, 08 May 2014 13:50:27 -0500
Subject: [PATCH v2] devicetree: bindings: separate CPU enable method
 descriptions
In-Reply-To: <1399574905-6478-1-git-send-email-elder@linaro.org>
References: <1399574905-6478-1-git-send-email-elder@linaro.org>
Message-ID: <536BD1F3.8010602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2014 01:48 PM, Alex Elder wrote:
> The bindings for CPU enable methods are defined in ".../arm/cpus.txt".  As
> additional 32-bit ARM CPUS are converted to use the "enable-method" CPU
> property to imply a particular set of SMP operations to use, the list of these
> methods is likely to become unwieldy.  The current documentation already
> contains several property descriptions that are meaningful only for certain
> enable methods.
...

I forgot to mention, this patch is available here:
	http://git.linaro.org/landing-teams/working/broadcom/kernel.git
        Branch review/enable-method-bindings-v2

					-Alex
