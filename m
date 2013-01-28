From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Jan 2013 08:11:16 +0000
Subject: [PATCH 26/26] mfd: ab8500-gpadc: Use new ab8500_gpadc_get() with
 name parameter
In-Reply-To: <20130127235405.GU1174@sortiz-mobl>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-27-git-send-email-lee.jones@linaro.org>
 <20130127235405.GU1174@sortiz-mobl>
Message-ID: <20130128081116.GW15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Samuel Ortiz wrote:

> Hi Lee,
> 
> On Tue, Jan 15, 2013 at 12:56:06PM +0000, Lee Jones wrote:
> > From: Philippe Langlais <philippe.langlais@linaro.org>
> > 
> > The new format of ab8500_gpadc_get() accepts a device name as a
> > parameter to specify which device to retrieve. This patch
> > enforces the use of that new format.
> Where is that new API coming from ? I couldn't find it in the previous 25
> patches. If it's there, this one should be merged with the patch that changes
> this API.

The API is already upstream:

6321992c (Daniel Willerud  2011-03-05 11:46:13 +0100 133) struct
  ab8500_gpadc *ab8500_gpadc_get(char *name)

The branch I'm trying to upstream from used the old one before now.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
