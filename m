From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 19 Aug 2016 17:24:15 +0100
Subject: [PATCH 05/13] scpi: move of_match table before probe functions
In-Reply-To: <1471515066-3626-6-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-6-git-send-email-narmstrong@baylibre.com>
Message-ID: <def54975-8014-a326-6f82-8953740e520c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/08/16 11:10, Neil Armstrong wrote:
> Move the of_match table to prapre adding new compatible strings, with
> match data in order to be used by the probe function.
>

I understand the need of this change, but can be part of the patch
introducing the need for this.

-- 
Regards,
Sudeep
