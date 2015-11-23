From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 23 Nov 2015 10:02:02 -0800
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and
 reporting
In-Reply-To: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
References: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151123180202.GM30882@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 10 Nov 07:57 PST 2015, Timur Tabi wrote:

> The driver doesn't report an error message if the ACPI tables are missing
> the num-gpios property (which indicates how many GPIOs there are on this
> SOC), and it didn't check to ensure that the mallocs didn't fail.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
