From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 24 Sep 2014 08:50:38 -0500
Subject: [PATCH v7 3/3] regulator: qcom-rpm: Regulator driver for the
 Qualcomm RPM
In-Reply-To: <20140924083518.GB4015@sirena.org.uk>
References: <1411428329-23172-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1411428329-23172-4-git-send-email-bjorn.andersson@sonymobile.com>
 <20140924083518.GB4015@sirena.org.uk>
Message-ID: <4437DA50-D8BC-4E78-821C-41440A08B9A9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 24, 2014, at 3:35 AM, Mark Brown <broonie@kernel.org> wrote:

> On Mon, Sep 22, 2014 at 04:25:29PM -0700, Bjorn Andersson wrote:
>> Driver for regulators exposed by the Resource Power Manager (RPM) found
>> in Qualcomm 8660, 8960 and 8064 based devices.
> 
> Applied, thanks.

Mark, can you drop this until we see at least an RFC patch for the RPM support for b-family SoCs (8074, 8084, etc) chips.  The regulator could should either be the same or highly similar for b-family, but until we see the core RPM driver on the b-family SoCs we will not know that.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
